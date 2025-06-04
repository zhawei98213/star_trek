import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// 日志级别
enum LogLevel {
  debug(0, 'DEBUG'),
  info(1, 'INFO'),
  warning(2, 'WARNING'),
  error(3, 'ERROR'),
  fatal(4, 'FATAL');

  const LogLevel(this.value, this.name);
  
  final int value;
  final String name;
  
  bool operator >=(LogLevel other) => value >= other.value;
  bool operator >(LogLevel other) => value > other.value;
  bool operator <=(LogLevel other) => value <= other.value;
  bool operator <(LogLevel other) => value < other.value;
}

/// 日志条目
class LogEntry {
  final DateTime timestamp;
  final LogLevel level;
  final String message;
  final String? tag;
  final Map<String, dynamic>? extra;
  final StackTrace? stackTrace;

  LogEntry({
    required this.timestamp,
    required this.level,
    required this.message,
    this.tag,
    this.extra,
    this.stackTrace,
  });

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'level': level.name,
      'message': message,
      'tag': tag,
      'extra': extra,
      'stackTrace': stackTrace?.toString(),
    };
  }

  /// 从JSON创建
  factory LogEntry.fromJson(Map<String, dynamic> json) {
    return LogEntry(
      timestamp: DateTime.parse(json['timestamp']),
      level: LogLevel.values.firstWhere(
        (l) => l.name == json['level'],
        orElse: () => LogLevel.info,
      ),
      message: json['message'],
      tag: json['tag'],
      extra: json['extra'],
      stackTrace: json['stackTrace'] != null 
          ? StackTrace.fromString(json['stackTrace']) 
          : null,
    );
  }

  /// 格式化输出
  String format() {
    final buffer = StringBuffer();
    
    // 时间戳
    buffer.write('[${timestamp.toIso8601String()}] ');
    
    // 级别
    buffer.write('[${level.name}] ');
    
    // 标签
    if (tag != null) {
      buffer.write('[$tag] ');
    }
    
    // 消息
    buffer.write(message);
    
    // 额外信息
    if (extra != null && extra!.isNotEmpty) {
      buffer.write(' | Extra: ${jsonEncode(extra)}');
    }
    
    // 堆栈跟踪
    if (stackTrace != null) {
      buffer.write('\nStackTrace:\n$stackTrace');
    }
    
    return buffer.toString();
  }
}

/// 日志输出器接口
abstract class LogOutput {
  Future<void> output(LogEntry entry);
  Future<void> close();
}

/// 控制台输出器
class ConsoleOutput implements LogOutput {
  final bool colorEnabled;
  
  ConsoleOutput({this.colorEnabled = true});
  
  @override
  Future<void> output(LogEntry entry) async {
    String output = entry.format();
    
    if (colorEnabled && !kIsWeb) {
      output = _colorize(output, entry.level);
    }
    
    if (kDebugMode) {
      debugPrint(output);
    } else {
      debugPrint(output);
    }
  }
  
  String _colorize(String text, LogLevel level) {
    const reset = '\x1B[0m';
    
    switch (level) {
      case LogLevel.debug:
        return '\x1B[37m$text$reset'; // 白色
      case LogLevel.info:
        return '\x1B[36m$text$reset'; // 青色
      case LogLevel.warning:
        return '\x1B[33m$text$reset'; // 黄色
      case LogLevel.error:
        return '\x1B[31m$text$reset'; // 红色
      case LogLevel.fatal:
        return '\x1B[35m$text$reset'; // 紫色
    }
  }
  
  @override
  Future<void> close() async {}
}

/// 文件输出器
class FileOutput implements LogOutput {
  final String fileName;
  final int maxFileSize;
  final int maxFiles;
  
  File? _currentFile;
  IOSink? _sink;
  int _currentFileSize = 0;
  
  FileOutput({
    this.fileName = 'app.log',
    this.maxFileSize = 10 * 1024 * 1024, // 10MB
    this.maxFiles = 5,
  });
  
  @override
  Future<void> output(LogEntry entry) async {
    await _ensureFile();
    
    final line = '${entry.format()}\n';
    final bytes = utf8.encode(line);
    
    // 检查是否需要轮转文件
    if (_currentFileSize + bytes.length > maxFileSize) {
      await _rotateFiles();
    }
    
    _sink?.add(bytes);
    await _sink?.flush();
    _currentFileSize += bytes.length;
  }
  
  Future<void> _ensureFile() async {
    if (_currentFile != null && _sink != null) return;
    
    final directory = await getApplicationDocumentsDirectory();
    final logDir = Directory('${directory.path}/logs');
    
    if (!await logDir.exists()) {
      await logDir.create(recursive: true);
    }
    
    _currentFile = File('${logDir.path}/$fileName');
    
    if (await _currentFile!.exists()) {
      _currentFileSize = await _currentFile!.length();
    } else {
      _currentFileSize = 0;
    }
    
    _sink = _currentFile!.openWrite(mode: FileMode.append);
  }
  
  Future<void> _rotateFiles() async {
    await _sink?.close();
    
    final directory = await getApplicationDocumentsDirectory();
    final logDir = Directory('${directory.path}/logs');
    
    // 轮转现有文件
    for (int i = maxFiles - 1; i > 0; i--) {
      final oldFile = File('${logDir.path}/$fileName.$i');
      final newFile = File('${logDir.path}/$fileName.${i + 1}');
      
      if (await oldFile.exists()) {
        if (i == maxFiles - 1) {
          await oldFile.delete(); // 删除最老的文件
        } else {
          await oldFile.rename(newFile.path);
        }
      }
    }
    
    // 重命名当前文件
    if (await _currentFile!.exists()) {
      await _currentFile!.rename('${logDir.path}/$fileName.1');
    }
    
    // 创建新文件
    _currentFile = File('${logDir.path}/$fileName');
    _sink = _currentFile!.openWrite();
    _currentFileSize = 0;
  }
  
  @override
  Future<void> close() async {
    await _sink?.close();
    _sink = null;
    _currentFile = null;
  }
}

/// 内存输出器（用于测试和调试）
class MemoryOutput implements LogOutput {
  final List<LogEntry> _entries = [];
  final int maxEntries;
  
  MemoryOutput({this.maxEntries = 1000});
  
  List<LogEntry> get entries => List.unmodifiable(_entries);
  
  @override
  Future<void> output(LogEntry entry) async {
    _entries.add(entry);
    
    // 保持最大条目数限制
    while (_entries.length > maxEntries) {
      _entries.removeAt(0);
    }
  }
  
  void clear() {
    _entries.clear();
  }
  
  @override
  Future<void> close() async {
    _entries.clear();
  }
}

/// 日志过滤器
typedef LogFilter = bool Function(LogEntry entry);

/// 日志格式化器
typedef LogFormatter = String Function(LogEntry entry);

/// 日志配置
class LoggerConfig {
  final LogLevel minLevel;
  final List<LogOutput> outputs;
  final LogFilter? filter;
  final LogFormatter? formatter;
  final bool enableInRelease;
  
  const LoggerConfig({
    this.minLevel = LogLevel.debug,
    this.outputs = const [],
    this.filter,
    this.formatter,
    this.enableInRelease = false,
  });
}

/// 日志管理器
class Logger {
  static Logger? _instance;
  static Logger get instance => _instance ??= Logger._();
  
  Logger._();
  
  LoggerConfig _config = const LoggerConfig();
  final StreamController<LogEntry> _logController = StreamController.broadcast();
  
  /// 日志流
  Stream<LogEntry> get logStream => _logController.stream;
  
  /// 初始化日志器
  void initialize(LoggerConfig config) {
    _config = config;
  }
  
  /// 记录日志
  void log(
    LogLevel level,
    String message, {
    String? tag,
    Map<String, dynamic>? extra,
    StackTrace? stackTrace,
  }) {
    // 检查是否应该记录日志
    if (!_shouldLog(level)) return;
    
    final entry = LogEntry(
      timestamp: DateTime.now(),
      level: level,
      message: message,
      tag: tag,
      extra: extra,
      stackTrace: stackTrace,
    );
    
    // 应用过滤器
    if (_config.filter != null && !_config.filter!(entry)) {
      return;
    }
    
    // 发送到流
    _logController.add(entry);
    
    // 输出到各个输出器
    for (final output in _config.outputs) {
      output.output(entry).catchError((error) {
        debugPrint('Log output error: $error');
      });
    }
  }
  
  bool _shouldLog(LogLevel level) {
    // 检查级别
    if (level < _config.minLevel) return false;
    
    // 检查是否在发布模式下启用
    if (kReleaseMode && !_config.enableInRelease) return false;
    
    return true;
  }
  
  /// Debug 日志
  void d(String message, {String? tag, Map<String, dynamic>? extra}) {
    log(LogLevel.debug, message, tag: tag, extra: extra);
  }
  
  /// Info 日志
  void i(String message, {String? tag, Map<String, dynamic>? extra}) {
    log(LogLevel.info, message, tag: tag, extra: extra);
  }
  
  /// Warning 日志
  void w(String message, {String? tag, Map<String, dynamic>? extra}) {
    log(LogLevel.warning, message, tag: tag, extra: extra);
  }
  
  /// Error 日志
  void e(
    String message, {
    String? tag,
    Map<String, dynamic>? extra,
    StackTrace? stackTrace,
  }) {
    log(
      LogLevel.error,
      message,
      tag: tag,
      extra: extra,
      stackTrace: stackTrace ?? StackTrace.current,
    );
  }
  
  /// Fatal 日志
  void f(
    String message, {
    String? tag,
    Map<String, dynamic>? extra,
    StackTrace? stackTrace,
  }) {
    log(
      LogLevel.fatal,
      message,
      tag: tag,
      extra: extra,
      stackTrace: stackTrace ?? StackTrace.current,
    );
  }
  
  /// 记录异常
  void exception(
    dynamic exception, {
    String? message,
    String? tag,
    Map<String, dynamic>? extra,
    StackTrace? stackTrace,
  }) {
    final errorMessage = message ?? 'Exception occurred: $exception';
    log(
      LogLevel.error,
      errorMessage,
      tag: tag,
      extra: {
        'exception': exception.toString(),
        'exceptionType': exception.runtimeType.toString(),
        ...?extra,
      },
      stackTrace: stackTrace ?? StackTrace.current,
    );
  }
  
  /// 性能日志
  void performance(
    String operation,
    Duration duration, {
    String? tag,
    Map<String, dynamic>? extra,
  }) {
    log(
      LogLevel.info,
      'Performance: $operation took ${duration.inMilliseconds}ms',
      tag: tag ?? 'PERFORMANCE',
      extra: {
        'operation': operation,
        'duration_ms': duration.inMilliseconds,
        ...?extra,
      },
    );
  }
  
  /// 网络日志
  void network(
    String method,
    String url,
    int statusCode, {
    Duration? duration,
    Map<String, dynamic>? extra,
  }) {
    final level = statusCode >= 400 ? LogLevel.error : LogLevel.info;
    final message = 'Network: $method $url [$statusCode]';
    
    log(
      level,
      message,
      tag: 'NETWORK',
      extra: {
        'method': method,
        'url': url,
        'statusCode': statusCode,
        'duration_ms': duration?.inMilliseconds,
        ...?extra,
      },
    );
  }
  
  /// 用户行为日志
  void userAction(
    String action, {
    String? screen,
    Map<String, dynamic>? parameters,
  }) {
    log(
      LogLevel.info,
      'User Action: $action',
      tag: 'USER_ACTION',
      extra: {
        'action': action,
        'screen': screen,
        'parameters': parameters,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }
  
  /// 关闭日志器
  Future<void> close() async {
    for (final output in _config.outputs) {
      await output.close();
    }
    await _logController.close();
  }
}

/// 日志装饰器
class LogDecorator {
  /// 装饰函数调用
  static T logFunction<T>(
    String functionName,
    T Function() function, {
    String? tag,
    LogLevel level = LogLevel.debug,
  }) {
    final stopwatch = Stopwatch()..start();
    
    Logger.instance.log(
      level,
      'Function started: $functionName',
      tag: tag ?? 'FUNCTION',
    );
    
    try {
      final result = function();
      stopwatch.stop();
      
      Logger.instance.log(
        level,
        'Function completed: $functionName (${stopwatch.elapsedMilliseconds}ms)',
        tag: tag ?? 'FUNCTION',
      );
      
      return result;
    } catch (e, stackTrace) {
      stopwatch.stop();
      
      Logger.instance.log(
        LogLevel.error,
        'Function failed: $functionName (${stopwatch.elapsedMilliseconds}ms)',
        tag: tag ?? 'FUNCTION',
        extra: {'error': e.toString()},
        stackTrace: stackTrace,
      );
      
      rethrow;
    }
  }
  
  /// 装饰异步函数调用
  static Future<T> logAsyncFunction<T>(
    String functionName,
    Future<T> Function() function, {
    String? tag,
    LogLevel level = LogLevel.debug,
  }) async {
    final stopwatch = Stopwatch()..start();
    
    Logger.instance.log(
      level,
      'Async function started: $functionName',
      tag: tag ?? 'ASYNC_FUNCTION',
    );
    
    try {
      final result = await function();
      stopwatch.stop();
      
      Logger.instance.log(
        level,
        'Async function completed: $functionName (${stopwatch.elapsedMilliseconds}ms)',
        tag: tag ?? 'ASYNC_FUNCTION',
      );
      
      return result;
    } catch (e, stackTrace) {
      stopwatch.stop();
      
      Logger.instance.log(
        LogLevel.error,
        'Async function failed: $functionName (${stopwatch.elapsedMilliseconds}ms)',
        tag: tag ?? 'ASYNC_FUNCTION',
        extra: {'error': e.toString()},
        stackTrace: stackTrace,
      );
      
      rethrow;
    }
  }
}

/// 日志混入
mixin LoggerMixin {
  Logger get logger => Logger.instance;
  
  void logDebug(String message, {Map<String, dynamic>? extra}) {
    logger.d(message, tag: runtimeType.toString(), extra: extra);
  }
  
  void logInfo(String message, {Map<String, dynamic>? extra}) {
    logger.i(message, tag: runtimeType.toString(), extra: extra);
  }
  
  void logWarning(String message, {Map<String, dynamic>? extra}) {
    logger.w(message, tag: runtimeType.toString(), extra: extra);
  }
  
  void logError(
    String message, {
    Map<String, dynamic>? extra,
    StackTrace? stackTrace,
  }) {
    logger.e(
      message,
      tag: runtimeType.toString(),
      extra: extra,
      stackTrace: stackTrace,
    );
  }
  
  void logException(
    dynamic exception, {
    String? message,
    Map<String, dynamic>? extra,
    StackTrace? stackTrace,
  }) {
    logger.exception(
      exception,
      message: message,
      tag: runtimeType.toString(),
      extra: extra,
      stackTrace: stackTrace,
    );
  }
}