import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 缓存项
class CacheItem<T> {
  final T data;
  final DateTime createdAt;
  final Duration? ttl;

  CacheItem({
    required this.data,
    required this.createdAt,
    this.ttl,
  });

  /// 检查是否过期
  bool get isExpired {
    if (ttl == null) return false;
    return DateTime.now().difference(createdAt) > ttl!;
  }

  /// 剩余有效时间
  Duration? get remainingTime {
    if (ttl == null) return null;
    final elapsed = DateTime.now().difference(createdAt);
    final remaining = ttl! - elapsed;
    return remaining.isNegative ? Duration.zero : remaining;
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'ttl': ttl?.inMilliseconds,
    };
  }

  factory CacheItem.fromJson(Map<String, dynamic> json) {
    return CacheItem(
      data: json['data'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      ttl: json['ttl'] != null ? Duration(milliseconds: json['ttl']) : null,
    );
  }
}

/// 内存缓存管理器
class MemoryCacheManager {
  static final Map<String, CacheItem> _cache = {};
  static Timer? _cleanupTimer;
  static const Duration _cleanupInterval = Duration(minutes: 5);

  /// 初始化缓存管理器
  static void initialize() {
    _startCleanupTimer();
  }

  /// 启动清理定时器
  static void _startCleanupTimer() {
    _cleanupTimer?.cancel();
    _cleanupTimer = Timer.periodic(_cleanupInterval, (_) {
      _cleanup();
    });
  }

  /// 设置缓存
  static void set<T>(String key, T data, {Duration? ttl}) {
    _cache[key] = CacheItem(
      data: data,
      createdAt: DateTime.now(),
      ttl: ttl,
    );
  }

  /// 获取缓存
  static T? get<T>(String key) {
    final item = _cache[key];
    if (item == null) return null;
    
    if (item.isExpired) {
      _cache.remove(key);
      return null;
    }
    
    return item.data as T?;
  }

  /// 检查缓存是否存在且有效
  static bool has(String key) {
    final item = _cache[key];
    if (item == null) return false;
    
    if (item.isExpired) {
      _cache.remove(key);
      return false;
    }
    
    return true;
  }

  /// 删除缓存
  static void remove(String key) {
    _cache.remove(key);
  }

  /// 清空所有缓存
  static void clear() {
    _cache.clear();
  }

  /// 清理过期缓存
  static void _cleanup() {
    final expiredKeys = <String>[];
    
    _cache.forEach((key, item) {
      if (item.isExpired) {
        expiredKeys.add(key);
      }
    });
    
    for (final key in expiredKeys) {
      _cache.remove(key);
    }
    
    if (kDebugMode && expiredKeys.isNotEmpty) {
      debugPrint('Cleaned up ${expiredKeys.length} expired cache items');
    }
  }

  /// 获取缓存统计信息
  static Map<String, dynamic> getStats() {
    int totalItems = _cache.length;
    int expiredItems = 0;
    
    _cache.forEach((key, item) {
      if (item.isExpired) {
        expiredItems++;
      }
    });
    
    return {
      'totalItems': totalItems,
      'validItems': totalItems - expiredItems,
      'expiredItems': expiredItems,
    };
  }

  /// 销毁缓存管理器
  static void dispose() {
    _cleanupTimer?.cancel();
    _cache.clear();
  }
}

/// 持久化缓存管理器
class PersistentCacheManager {
  static SharedPreferences? _prefs;
  static const String _cachePrefix = 'cache_';

  /// 初始化
  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// 设置缓存
  static Future<void> set<T>(String key, T data, {Duration? ttl}) async {
    if (_prefs == null) await initialize();
    
    final item = CacheItem(
      data: data,
      createdAt: DateTime.now(),
      ttl: ttl,
    );
    
    final jsonString = jsonEncode(item.toJson());
    await _prefs!.setString('$_cachePrefix$key', jsonString);
  }

  /// 获取缓存
  static Future<T?> get<T>(String key) async {
    if (_prefs == null) await initialize();
    
    final jsonString = _prefs!.getString('$_cachePrefix$key');
    if (jsonString == null) return null;
    
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final item = CacheItem.fromJson(json);
      
      if (item.isExpired) {
        await remove(key);
        return null;
      }
      
      return item.data as T?;
    } catch (e) {
      // 如果解析失败，删除损坏的缓存
      await remove(key);
      return null;
    }
  }

  /// 检查缓存是否存在且有效
  static Future<bool> has(String key) async {
    final data = await get(key);
    return data != null;
  }

  /// 删除缓存
  static Future<void> remove(String key) async {
    if (_prefs == null) await initialize();
    await _prefs!.remove('$_cachePrefix$key');
  }

  /// 清空所有缓存
  static Future<void> clear() async {
    if (_prefs == null) await initialize();
    
    final keys = _prefs!.getKeys()
        .where((key) => key.startsWith(_cachePrefix))
        .toList();
    
    for (final key in keys) {
      await _prefs!.remove(key);
    }
  }

  /// 清理过期缓存
  static Future<void> cleanup() async {
    if (_prefs == null) await initialize();
    
    final keys = _prefs!.getKeys()
        .where((key) => key.startsWith(_cachePrefix))
        .toList();
    
    int cleanedCount = 0;
    
    for (final key in keys) {
      final jsonString = _prefs!.getString(key);
      if (jsonString == null) continue;
      
      try {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        final item = CacheItem.fromJson(json);
        
        if (item.isExpired) {
          await _prefs!.remove(key);
          cleanedCount++;
        }
      } catch (e) {
        // 删除损坏的缓存
        await _prefs!.remove(key);
        cleanedCount++;
      }
    }
    
    if (kDebugMode && cleanedCount > 0) {
      debugPrint('Cleaned up $cleanedCount expired persistent cache items');
    }
  }

  /// 获取缓存统计信息
  static Future<Map<String, dynamic>> getStats() async {
    if (_prefs == null) await initialize();
    
    final keys = _prefs!.getKeys()
        .where((key) => key.startsWith(_cachePrefix))
        .toList();
    
    int totalItems = keys.length;
    int validItems = 0;
    int expiredItems = 0;
    int corruptedItems = 0;
    
    for (final key in keys) {
      final jsonString = _prefs!.getString(key);
      if (jsonString == null) continue;
      
      try {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        final item = CacheItem.fromJson(json);
        
        if (item.isExpired) {
          expiredItems++;
        } else {
          validItems++;
        }
      } catch (e) {
        corruptedItems++;
      }
    }
    
    return {
      'totalItems': totalItems,
      'validItems': validItems,
      'expiredItems': expiredItems,
      'corruptedItems': corruptedItems,
    };
  }
}

/// 统一缓存管理器
class CacheManager {
  /// 设置内存缓存
  static void setMemory<T>(String key, T data, {Duration? ttl}) {
    MemoryCacheManager.set(key, data, ttl: ttl);
  }

  /// 获取内存缓存
  static T? getMemory<T>(String key) {
    return MemoryCacheManager.get<T>(key);
  }

  /// 设置持久化缓存
  static Future<void> setPersistent<T>(String key, T data, {Duration? ttl}) async {
    await PersistentCacheManager.set(key, data, ttl: ttl);
  }

  /// 获取持久化缓存
  static Future<T?> getPersistent<T>(String key) async {
    return await PersistentCacheManager.get<T>(key);
  }

  /// 设置双层缓存（内存+持久化）
  static Future<void> setBoth<T>(String key, T data, {Duration? ttl}) async {
    setMemory(key, data, ttl: ttl);
    await setPersistent(key, data, ttl: ttl);
  }

  /// 获取双层缓存（优先内存，然后持久化）
  static Future<T?> getBoth<T>(String key) async {
    // 先尝试内存缓存
    final memoryData = getMemory<T>(key);
    if (memoryData != null) {
      return memoryData;
    }
    
    // 再尝试持久化缓存
    final persistentData = await getPersistent<T>(key);
    if (persistentData != null) {
      // 将持久化数据加载到内存缓存
      setMemory(key, persistentData);
      return persistentData;
    }
    
    return null;
  }

  /// 删除所有类型的缓存
  static Future<void> remove(String key) async {
    MemoryCacheManager.remove(key);
    await PersistentCacheManager.remove(key);
  }

  /// 清空所有缓存
  static Future<void> clearAll() async {
    MemoryCacheManager.clear();
    await PersistentCacheManager.clear();
  }

  /// 清理过期缓存
  static Future<void> cleanup() async {
    MemoryCacheManager._cleanup();
    await PersistentCacheManager.cleanup();
  }

  /// 初始化缓存管理器
  static Future<void> initialize() async {
    MemoryCacheManager.initialize();
    await PersistentCacheManager.initialize();
  }

  /// 获取综合统计信息
  static Future<Map<String, dynamic>> getStats() async {
    final memoryStats = MemoryCacheManager.getStats();
    final persistentStats = await PersistentCacheManager.getStats();
    
    return {
      'memory': memoryStats,
      'persistent': persistentStats,
    };
  }

  /// 销毁缓存管理器
  static void dispose() {
    MemoryCacheManager.dispose();
  }
}