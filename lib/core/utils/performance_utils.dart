import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 性能优化工具类
class PerformanceUtils {
  /// 防抖函数
  static Timer? _debounceTimer;
  static void debounce(VoidCallback callback, {Duration delay = const Duration(milliseconds: 300)}) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, callback);
  }
  
  /// 节流函数
  static bool _isThrottling = false;
  static void throttle(VoidCallback callback, {Duration delay = const Duration(milliseconds: 300)}) {
    if (!_isThrottling) {
      _isThrottling = true;
      callback();
      Timer(delay, () {
        _isThrottling = false;
      });
    }
  }
  
  /// 延迟执行
  static Future<void> delayedExecution(VoidCallback callback, {Duration delay = const Duration(milliseconds: 100)}) async {
    await Future.delayed(delay);
    callback();
  }
  
  /// 批量更新状态
  static void batchStateUpdate(List<VoidCallback> updates) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (final update in updates) {
        update();
      }
    });
  }
  
  /// 内存使用监控
  static void logMemoryUsage(String tag) {
    if (kDebugMode) {
      final info = ProcessInfo.currentRss;
      debugPrint('[$tag] Memory usage: ${(info / 1024 / 1024).toStringAsFixed(2)} MB');
    }
  }
  
  /// 帧率监控
  static void startFrameRateMonitoring() {
    if (kDebugMode) {
      WidgetsBinding.instance.addTimingsCallback((timings) {
        for (final timing in timings) {
          final frameTime = timing.totalSpan.inMilliseconds;
          if (frameTime > 16) { // 超过16ms表示掉帧
            debugPrint('Frame drop detected: ${frameTime}ms');
          }
        }
      });
    }
  }
  
  /// 预加载图片
  static Future<void> preloadImages(BuildContext context, List<String> imagePaths) async {
    final futures = imagePaths.map((path) {
      return precacheImage(AssetImage(path), context);
    }).toList();
    
    await Future.wait(futures);
  }
  
  /// 优化的列表构建器
  static Widget buildOptimizedListView<T>({
    required List<T> items,
    required Widget Function(BuildContext, T, int) itemBuilder,
    ScrollController? controller,
    bool shrinkWrap = false,
    ScrollPhysics? physics,
  }) {
    return ListView.builder(
      controller: controller,
      itemCount: items.length,
      shrinkWrap: shrinkWrap,
      physics: physics,
      cacheExtent: 1000, // 预缓存范围
      itemBuilder: (context, index) {
        final item = items[index];
        return RepaintBoundary(
          child: itemBuilder(context, item, index),
        );
      },
    );
  }
  
  /// 优化的网格构建器
  static Widget buildOptimizedGridView<T>({
    required List<T> items,
    required Widget Function(BuildContext, T, int) itemBuilder,
    required SliverGridDelegate gridDelegate,
    ScrollController? controller,
    bool shrinkWrap = false,
    ScrollPhysics? physics,
  }) {
    return GridView.builder(
      controller: controller,
      itemCount: items.length,
      gridDelegate: gridDelegate,
      shrinkWrap: shrinkWrap,
      physics: physics,
      cacheExtent: 1000,
      itemBuilder: (context, index) {
        final item = items[index];
        return RepaintBoundary(
          child: itemBuilder(context, item, index),
        );
      },
    );
  }
}

/// 性能监控Mixin
mixin PerformanceMonitorMixin<T extends StatefulWidget> on State<T> {
  late final Stopwatch _stopwatch;
  
  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch()..start();
    PerformanceUtils.logMemoryUsage('${widget.runtimeType}_initState');
  }
  
  @override
  void dispose() {
    _stopwatch.stop();
    if (kDebugMode) {
      debugPrint('${widget.runtimeType} lifecycle: ${_stopwatch.elapsedMilliseconds}ms');
    }
    PerformanceUtils.logMemoryUsage('${widget.runtimeType}_dispose');
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final buildStopwatch = Stopwatch()..start();
    final widget = buildWidget(context);
    buildStopwatch.stop();
    
    if (kDebugMode && buildStopwatch.elapsedMilliseconds > 16) {
      debugPrint('${this.widget.runtimeType} build took: ${buildStopwatch.elapsedMilliseconds}ms');
    }
    
    return widget;
  }
  
  Widget buildWidget(BuildContext context);
}