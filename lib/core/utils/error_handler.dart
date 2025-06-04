import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 错误类型枚举
enum ErrorType {
  network,
  validation,
  authentication,
  permission,
  storage,
  unknown,
}

/// 应用错误类
class AppError implements Exception {
  final String message;
  final ErrorType type;
  final String? code;
  final dynamic originalError;
  final StackTrace? stackTrace;
  final DateTime? timestamp;

  const AppError({
    required this.message,
    required this.type,
    this.code,
    this.originalError,
    this.stackTrace,
    this.timestamp,
  });

  AppError._(
    this.message,
    this.type,
    this.code,
    this.originalError,
    this.stackTrace,
    this.timestamp,
  );

  factory AppError.create({
    required String message,
    required ErrorType type,
    String? code,
    dynamic originalError,
    StackTrace? stackTrace,
  }) {
    return AppError._(
      message,
      type,
      code,
      originalError,
      stackTrace,
      DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'AppError(type: $type, message: $message, code: $code)';
  }
}

/// 错误处理器
class ErrorHandler {
  static final List<AppError> _errorHistory = [];
  static ErrorHandlerConfig _config = const ErrorHandlerConfig();
  static bool _isInitialized = false;

  /// 初始化错误处理器
  static void initialize(ErrorHandlerConfig config) {
    if (_isInitialized) return;
    
    _config = config;
    
    // 设置Flutter错误处理
    FlutterError.onError = (FlutterErrorDetails details) {
      handleError(details.exception, stackTrace: details.stack);
    };
    
    _isInitialized = true;
  }

  /// 处理错误
  static void handleError(
    dynamic error, {
    StackTrace? stackTrace,
    String? context,
    bool showToUser = true,
  }) {
    final appError = _convertToAppError(error, stackTrace);
    
    // 记录错误
    _logError(appError, context);
    
    // 保存到历史记录
    _saveToHistory(appError);
    
    // 根据错误类型决定是否显示给用户
    if (showToUser) {
      _showErrorToUser(appError);
    }
  }

  /// 转换为应用错误
  static AppError _convertToAppError(dynamic error, StackTrace? stackTrace) {
    if (error is AppError) {
      return error;
    }

    String message;
    ErrorType type;
    String? code;

    if (error is FormatException) {
      message = '数据格式错误';
      type = ErrorType.validation;
    } else if (error is TimeoutException) {
      message = '请求超时，请检查网络连接';
      type = ErrorType.network;
    } else if (error is Exception) {
      message = error.toString();
      type = ErrorType.unknown;
    } else {
      message = '未知错误: $error';
      type = ErrorType.unknown;
    }

    return AppError.create(
      message: message,
      type: type,
      code: code,
      originalError: error,
      stackTrace: stackTrace,
    );
  }

  /// 记录错误日志
  static void _logError(AppError error, String? context) {
    final contextInfo = context != null ? '[$context] ' : '';
    final logMessage = '$contextInfo${error.toString()}';

    if (kDebugMode) {
      developer.log(
        logMessage,
        name: 'ErrorHandler',
        error: error.originalError,
        stackTrace: error.stackTrace,
        level: 1000, // Error level
      );
    }

    // 在生产环境中，这里可以发送到错误监控服务
    // 例如: Sentry, Crashlytics, 等
  }

  /// 保存到错误历史
  static void _saveToHistory(AppError error) {
    _errorHistory.add(error);
    
    // 保持历史记录大小限制
    while (_errorHistory.length > _config.maxErrorHistory) {
      _errorHistory.removeAt(0);
    }
  }

  /// 显示错误给用户
  static void _showErrorToUser(AppError error) {
    // 这里需要一个全局的方式来显示错误
    // 可以通过全局的 ScaffoldMessenger 或者自定义的错误显示组件
    debugPrint('显示错误给用户: ${error.message}');
  }

  /// 获取错误历史
  static List<AppError> getErrorHistory() {
    return List.unmodifiable(_errorHistory);
  }

  /// 清除错误历史
  static void clearErrorHistory() {
    _errorHistory.clear();
  }

  /// 获取用户友好的错误消息
  static String getUserFriendlyMessage(AppError error) {
    switch (error.type) {
      case ErrorType.network:
        return '网络连接出现问题，请检查您的网络设置';
      case ErrorType.validation:
        return '输入的信息格式不正确，请检查后重试';
      case ErrorType.authentication:
        return '身份验证失败，请重新登录';
      case ErrorType.permission:
        return '没有足够的权限执行此操作';
      case ErrorType.storage:
        return '存储空间不足或访问受限';
      case ErrorType.unknown:
        return '出现了未知错误，请稍后重试';
    }
  }
}

/// 错误边界Widget
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(AppError error)? errorBuilder;
  final void Function(AppError error)? onError;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
    this.onError,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  AppError? _error;

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.errorBuilder?.call(_error!) ??
          _DefaultErrorWidget(error: _error!);
    }

    return widget.child;
  }

  void reset() {
    setState(() {
      _error = null;
    });
  }
}

/// 默认错误显示Widget
class _DefaultErrorWidget extends StatelessWidget {
  final AppError error;

  const _DefaultErrorWidget({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              ErrorHandler.getUserFriendlyMessage(error),
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 重置错误状态
                if (context.findAncestorStateOfType<_ErrorBoundaryState>() != null) {
                  context.findAncestorStateOfType<_ErrorBoundaryState>()!.reset();
                }
              },
              child: const Text('重试'),
            ),
          ],
        ),
      ),
    );
  }
}

/// 错误处理配置
class ErrorHandlerConfig {
  final bool enableCrashReporting;
  final int maxErrorHistory;
  final bool enableLogging;
  final bool showErrorDialog;
  final Duration errorDisplayDuration;

  const ErrorHandlerConfig({
    this.enableCrashReporting = false,
    this.maxErrorHistory = 100,
    this.enableLogging = true,
    this.showErrorDialog = true,
    this.errorDisplayDuration = const Duration(seconds: 5),
  });
}

/// 全局错误处理混入
mixin GlobalErrorHandlerMixin {
  /// 设置全局错误处理
  void setupGlobalErrorHandling() {
    FlutterError.onError = (FlutterErrorDetails details) {
      ErrorHandler.handleError(details.exception, stackTrace: details.stack);
    };
  }

  /// 安全执行操作
  Future<T?> safeExecute<T>(
    Future<T> Function() operation, {
    String? operationName,
    T? fallbackValue,
  }) async {
    try {
      return await operation();
    } catch (e, stackTrace) {
      ErrorHandler.handleError(
        e,
        stackTrace: stackTrace,
        context: operationName ?? 'Unknown operation',
      );
      return fallbackValue;
    }
  }

  /// 安全执行同步操作
  T? safeExecuteSync<T>(
    T Function() operation, {
    String? operationName,
    T? fallbackValue,
  }) {
    try {
      return operation();
    } catch (e, stackTrace) {
      ErrorHandler.handleError(
        e,
        stackTrace: stackTrace,
        context: operationName ?? 'Unknown operation',
      );
      return fallbackValue;
    }
  }
}