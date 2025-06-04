import 'package:flutter/foundation.dart';
import '../utils/cache_manager.dart';
import '../utils/logger.dart';
import '../utils/network_manager.dart';
import '../utils/error_handler.dart';

/// 应用环境
enum AppEnvironment {
  development,
  staging,
  production,
}

/// 应用配置
class AppConfig {
  static AppConfig? _instance;
  static AppConfig get instance => _instance ??= AppConfig._();
  
  AppConfig._();
  
  late AppEnvironment _environment;
  late Map<String, dynamic> _config;
  
  /// 当前环境
  AppEnvironment get environment => _environment;
  
  /// 是否为开发环境
  bool get isDevelopment => _environment == AppEnvironment.development;
  
  /// 是否为生产环境
  bool get isProduction => _environment == AppEnvironment.production;
  
  /// 初始化配置
  Future<void> initialize({
    AppEnvironment environment = AppEnvironment.development,
    Map<String, dynamic>? customConfig,
  }) async {
    _environment = environment;
    _config = {
      ..._getDefaultConfig(),
      ..._getEnvironmentConfig(environment),
      ...?customConfig,
    };
    
    // 初始化各个管理器
    await _initializeManagers();
  }
  
  /// 获取配置值
  T get<T>(String key, {T? defaultValue}) {
    final value = _config[key];
    if (value is T) {
      return value;
    }
    if (defaultValue != null) {
      return defaultValue;
    }
    throw ArgumentError('Config key "$key" not found or type mismatch');
  }
  
  /// 设置配置值
  void set(String key, dynamic value) {
    _config[key] = value;
  }
  
  /// 获取默认配置
  Map<String, dynamic> _getDefaultConfig() {
    return {
      // 应用信息
      'app_name': 'Star Trek Learning',
      'app_version': '1.0.0',
      
      // 网络配置
      'api_timeout': 30000, // 30秒
      'max_retries': 3,
      'retry_delay': 1000, // 1秒
      
      // 缓存配置
      'cache_max_size': 100 * 1024 * 1024, // 100MB
      'cache_ttl': 24 * 60 * 60 * 1000, // 24小时
      
      // 日志配置
      'log_level': 'debug',
      'log_to_file': true,
      'log_max_files': 5,
      'log_max_file_size': 10 * 1024 * 1024, // 10MB
      
      // 性能配置
      'enable_performance_monitoring': true,
      'frame_rate_threshold': 55, // FPS阈值
      
      // 错误处理
      'enable_crash_reporting': false,
      'max_error_history': 100,
      
      // 功能开关
      'enable_analytics': false,
      'enable_push_notifications': false,
      'enable_offline_mode': true,
      
      // UI配置
      'theme_mode': 'system', // system, light, dark
      'enable_animations': true,
      'animation_duration': 300,
      
      // 学习配置
      'auto_save_progress': true,
      'save_interval': 30000, // 30秒
      'max_learning_sessions': 10,
    };
  }
  
  /// 获取环境特定配置
  Map<String, dynamic> _getEnvironmentConfig(AppEnvironment environment) {
    switch (environment) {
      case AppEnvironment.development:
        return {
          'api_base_url': 'https://dev-api.startrek-learning.com',
          'enable_debug_tools': true,
          'log_level': 'debug',
          'enable_crash_reporting': false,
          'enable_analytics': false,
        };
      
      case AppEnvironment.staging:
        return {
          'api_base_url': 'https://staging-api.startrek-learning.com',
          'enable_debug_tools': true,
          'log_level': 'info',
          'enable_crash_reporting': true,
          'enable_analytics': false,
        };
      
      case AppEnvironment.production:
        return {
          'api_base_url': 'https://api.startrek-learning.com',
          'enable_debug_tools': false,
          'log_level': 'warning',
          'enable_crash_reporting': true,
          'enable_analytics': true,
        };
    }
  }
  
  /// 初始化各个管理器
  Future<void> _initializeManagers() async {
    // 初始化日志管理器
    await _initializeLogger();
    
    // 初始化缓存管理器
    await _initializeCacheManager();
    
    // 初始化网络管理器
    await _initializeNetworkManager();
    
    // 初始化错误处理器
    await _initializeErrorHandler();
  }
  
  /// 初始化日志管理器
  Future<void> _initializeLogger() async {
    final outputs = <LogOutput>[];
    
    // 控制台输出
    outputs.add(ConsoleOutput(colorEnabled: !kIsWeb));
    
    // 文件输出（仅在非Web平台）
    if (!kIsWeb && get<bool>('log_to_file', defaultValue: false)) {
      outputs.add(FileOutput(
        fileName: 'app.log',
        maxFileSize: get<int>('log_max_file_size'),
        maxFiles: get<int>('log_max_files'),
      ));
    }
    
    // 内存输出（用于调试）
    if (isDevelopment) {
      outputs.add(MemoryOutput(maxEntries: 1000));
    }
    
    final logLevel = _parseLogLevel(get<String>('log_level'));
    
    Logger.instance.initialize(LoggerConfig(
      minLevel: logLevel,
      outputs: outputs,
      enableInRelease: isProduction,
    ));
    
    Logger.instance.i('Logger initialized', tag: 'APP_CONFIG');
  }
  
  /// 初始化缓存管理器
  Future<void> _initializeCacheManager() async {
    await CacheManager.initialize();
    Logger.instance.i('Cache manager initialized', tag: 'APP_CONFIG');
  }
  
  /// 初始化网络管理器
  Future<void> _initializeNetworkManager() async {
    final config = NetworkConfig(
      baseUrl: get<String>('api_base_url'),
      timeout: Duration(milliseconds: get<int>('api_timeout')),
      maxRetries: get<int>('max_retries'),
      retryDelay: Duration(milliseconds: get<int>('retry_delay')),
      enableLogging: isDevelopment,
      defaultHeaders: {
        'User-Agent': '${get<String>('app_name')}/${get<String>('app_version')}',
        'Accept': 'application/json',
      },
    );
    
    NetworkManager.instance.initialize(config: config);
    Logger.instance.i('Network manager initialized', tag: 'APP_CONFIG');
  }
  
  /// 初始化错误处理器
  Future<void> _initializeErrorHandler() async {
    ErrorHandler.initialize(ErrorHandlerConfig(
      enableCrashReporting: get<bool>('enable_crash_reporting'),
      maxErrorHistory: get<int>('max_error_history'),
      enableLogging: true,
    ));
    
    Logger.instance.i('Error handler initialized', tag: 'APP_CONFIG');
  }
  
  /// 解析日志级别
  LogLevel _parseLogLevel(String level) {
    switch (level.toLowerCase()) {
      case 'debug':
        return LogLevel.debug;
      case 'info':
        return LogLevel.info;
      case 'warning':
        return LogLevel.warning;
      case 'error':
        return LogLevel.error;
      case 'fatal':
        return LogLevel.fatal;
      default:
        return LogLevel.info;
    }
  }
  
  /// 获取所有配置
  Map<String, dynamic> getAllConfig() {
    return Map.unmodifiable(_config);
  }
  
  /// 重新加载配置
  Future<void> reload({
    AppEnvironment? environment,
    Map<String, dynamic>? customConfig,
  }) async {
    await initialize(
      environment: environment ?? _environment,
      customConfig: customConfig,
    );
  }
  
  /// 清理资源
  Future<void> dispose() async {
    await Logger.instance.close();
    CacheManager.dispose();
    NetworkManager.instance.dispose();
  }
}

/// 应用配置扩展
extension AppConfigExtension on AppConfig {
  /// 网络配置
  NetworkConfig get networkConfig => NetworkConfig(
    baseUrl: get<String>('api_base_url'),
    timeout: Duration(milliseconds: get<int>('api_timeout')),
    maxRetries: get<int>('max_retries'),
    retryDelay: Duration(milliseconds: get<int>('retry_delay')),
    enableLogging: isDevelopment,
  );
  
  /// 缓存配置
  Map<String, dynamic> get cacheConfig => {
    'max_size': get<int>('cache_max_size'),
    'ttl': get<int>('cache_ttl'),
  };
  
  /// 性能配置
  Map<String, dynamic> get performanceConfig => {
    'enable_monitoring': get<bool>('enable_performance_monitoring'),
    'frame_rate_threshold': get<int>('frame_rate_threshold'),
  };
  
  /// UI配置
  Map<String, dynamic> get uiConfig => {
    'theme_mode': get<String>('theme_mode'),
    'enable_animations': get<bool>('enable_animations'),
    'animation_duration': get<int>('animation_duration'),
  };
  
  /// 学习配置
  Map<String, dynamic> get learningConfig => {
    'auto_save_progress': get<bool>('auto_save_progress'),
    'save_interval': get<int>('save_interval'),
    'max_learning_sessions': get<int>('max_learning_sessions'),
  };
}