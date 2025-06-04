import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// 网络请求结果
class NetworkResult<T> {
  final bool isSuccess;
  final T? data;
  final String? error;
  final int? statusCode;
  final Map<String, String>? headers;

  NetworkResult.success({
    required this.data,
    this.statusCode,
    this.headers,
  }) : isSuccess = true, error = null;

  NetworkResult.failure({
    required this.error,
    this.statusCode,
    this.headers,
  }) : isSuccess = false, data = null;
}

/// 网络请求配置
class NetworkConfig {
  final String baseUrl;
  final Duration timeout;
  final Map<String, String> defaultHeaders;
  final bool enableLogging;
  final int maxRetries;
  final Duration retryDelay;

  const NetworkConfig({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 30),
    this.defaultHeaders = const {},
    this.enableLogging = kDebugMode,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  });
}

/// 网络连接状态
enum NetworkStatus {
  connected,
  disconnected,
  unknown,
}

/// 网络管理器
class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager get instance => _instance ??= NetworkManager._();
  
  NetworkManager._();

  late http.Client _client;
  late NetworkConfig _config;
  NetworkStatus _status = NetworkStatus.unknown;
  Timer? _statusCheckTimer;
  final StreamController<NetworkStatus> _statusController = StreamController.broadcast();

  /// 网络状态流
  Stream<NetworkStatus> get statusStream => _statusController.stream;

  /// 当前网络状态
  NetworkStatus get status => _status;

  /// 初始化网络管理器
  void initialize({
    required NetworkConfig config,
    http.Client? client,
  }) {
    _config = config;
    _client = client ?? http.Client();
    _startStatusMonitoring();
  }

  /// 开始网络状态监控
  void _startStatusMonitoring() {
    _statusCheckTimer?.cancel();
    _statusCheckTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _checkNetworkStatus(),
    );
    _checkNetworkStatus(); // 立即检查一次
  }

  /// 检查网络状态
  Future<void> _checkNetworkStatus() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      
      final newStatus = result.isNotEmpty && result[0].rawAddress.isNotEmpty
          ? NetworkStatus.connected
          : NetworkStatus.disconnected;
      
      if (newStatus != _status) {
        _status = newStatus;
        _statusController.add(_status);
        
        if (_config.enableLogging) {
          debugPrint('Network status changed: $_status');
        }
      }
    } catch (e) {
      if (_status != NetworkStatus.disconnected) {
        _status = NetworkStatus.disconnected;
        _statusController.add(_status);
        
        if (_config.enableLogging) {
          debugPrint('Network status changed: $_status (Error: $e)');
        }
      }
    }
  }

  /// GET 请求
  Future<NetworkResult<T>> get<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _makeRequest<T>(
      'GET',
      endpoint,
      headers: headers,
      queryParameters: queryParameters,
      fromJson: fromJson,
    );
  }

  /// POST 请求
  Future<NetworkResult<T>> post<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _makeRequest<T>(
      'POST',
      endpoint,
      headers: headers,
      body: body,
      queryParameters: queryParameters,
      fromJson: fromJson,
    );
  }

  /// PUT 请求
  Future<NetworkResult<T>> put<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _makeRequest<T>(
      'PUT',
      endpoint,
      headers: headers,
      body: body,
      queryParameters: queryParameters,
      fromJson: fromJson,
    );
  }

  /// DELETE 请求
  Future<NetworkResult<T>> delete<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _makeRequest<T>(
      'DELETE',
      endpoint,
      headers: headers,
      queryParameters: queryParameters,
      fromJson: fromJson,
    );
  }

  /// 执行网络请求
  Future<NetworkResult<T>> _makeRequest<T>(
    String method,
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    // 检查网络连接
    if (_status == NetworkStatus.disconnected) {
      return NetworkResult.failure(
        error: 'No internet connection',
        statusCode: 0,
      );
    }

    // 构建URL
    final uri = _buildUri(endpoint, queryParameters);
    
    // 合并请求头
    final requestHeaders = {
      ..._config.defaultHeaders,
      'Content-Type': 'application/json',
      ...?headers,
    };

    int retryCount = 0;
    
    while (retryCount <= _config.maxRetries) {
      try {
        if (_config.enableLogging) {
          debugPrint('[$method] $uri');
          if (body != null) {
            debugPrint('Body: ${jsonEncode(body)}');
          }
        }

        late http.Response response;
        
        switch (method.toUpperCase()) {
          case 'GET':
            response = await _client.get(uri, headers: requestHeaders)
                .timeout(_config.timeout);
            break;
          case 'POST':
            response = await _client.post(
              uri,
              headers: requestHeaders,
              body: body != null ? jsonEncode(body) : null,
            ).timeout(_config.timeout);
            break;
          case 'PUT':
            response = await _client.put(
              uri,
              headers: requestHeaders,
              body: body != null ? jsonEncode(body) : null,
            ).timeout(_config.timeout);
            break;
          case 'DELETE':
            response = await _client.delete(uri, headers: requestHeaders)
                .timeout(_config.timeout);
            break;
          default:
            throw UnsupportedError('HTTP method $method not supported');
        }

        if (_config.enableLogging) {
          debugPrint('Response [${response.statusCode}]: ${response.body}');
        }

        if (response.statusCode >= 200 && response.statusCode < 300) {
          // 成功响应
          T? data;
          
          if (response.body.isNotEmpty) {
            try {
              final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
              data = fromJson?.call(jsonData) ?? jsonData as T?;
            } catch (e) {
              // 如果不是JSON格式，直接返回字符串
              data = response.body as T?;
            }
          }
          
          return NetworkResult.success(
            data: data,
            statusCode: response.statusCode,
            headers: response.headers,
          );
        } else {
          // 错误响应
          String errorMessage;
          try {
            final errorJson = jsonDecode(response.body) as Map<String, dynamic>;
            errorMessage = errorJson['message'] ?? errorJson['error'] ?? 'Unknown error';
          } catch (e) {
            errorMessage = response.body.isNotEmpty ? response.body : 'HTTP ${response.statusCode}';
          }
          
          return NetworkResult.failure(
            error: errorMessage,
            statusCode: response.statusCode,
            headers: response.headers,
          );
        }
      } catch (e) {
        if (_config.enableLogging) {
          debugPrint('Request failed (attempt ${retryCount + 1}): $e');
        }
        
        // 如果是最后一次重试或者是不可重试的错误
        if (retryCount >= _config.maxRetries || !_shouldRetry(e)) {
          return NetworkResult.failure(
            error: _getErrorMessage(e),
            statusCode: 0,
          );
        }
        
        retryCount++;
        
        // 等待后重试
        await Future.delayed(_config.retryDelay * retryCount);
      }
    }
    
    return NetworkResult.failure(
      error: 'Request failed after ${_config.maxRetries} retries',
      statusCode: 0,
    );
  }

  /// 构建URI
  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParameters) {
    final url = endpoint.startsWith('http') 
        ? endpoint 
        : '${_config.baseUrl.endsWith('/') ? _config.baseUrl.substring(0, _config.baseUrl.length - 1) : _config.baseUrl}/$endpoint';
    
    final uri = Uri.parse(url);
    
    if (queryParameters != null && queryParameters.isNotEmpty) {
      final queryString = queryParameters.entries
          .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
          .join('&');
      
      return Uri.parse('$url?$queryString');
    }
    
    return uri;
  }

  /// 判断是否应该重试
  bool _shouldRetry(dynamic error) {
    if (error is SocketException) return true;
    if (error is TimeoutException) return true;
    if (error is HttpException) return true;
    return false;
  }

  /// 获取错误消息
  String _getErrorMessage(dynamic error) {
    if (error is SocketException) {
      return 'Network connection failed';
    }
    if (error is TimeoutException) {
      return 'Request timeout';
    }
    if (error is HttpException) {
      return 'HTTP error: ${error.message}';
    }
    return error.toString();
  }

  /// 上传文件
  Future<NetworkResult<T>> uploadFile<T>(
    String endpoint,
    String filePath,
    String fieldName, {
    Map<String, String>? headers,
    Map<String, String>? fields,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = _buildUri(endpoint, null);
      final request = http.MultipartRequest('POST', uri);
      
      // 添加请求头
      request.headers.addAll({
        ..._config.defaultHeaders,
        ...?headers,
      });
      
      // 添加字段
      if (fields != null) {
        request.fields.addAll(fields);
      }
      
      // 添加文件
      final file = await http.MultipartFile.fromPath(fieldName, filePath);
      request.files.add(file);
      
      if (_config.enableLogging) {
        debugPrint('[UPLOAD] $uri');
        debugPrint('File: $filePath');
      }
      
      final streamedResponse = await request.send().timeout(_config.timeout);
      final response = await http.Response.fromStream(streamedResponse);
      
      if (_config.enableLogging) {
        debugPrint('Upload Response [${response.statusCode}]: ${response.body}');
      }
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        T? data;
        
        if (response.body.isNotEmpty) {
          try {
            final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
            data = fromJson?.call(jsonData) ?? jsonData as T?;
          } catch (e) {
            data = response.body as T?;
          }
        }
        
        return NetworkResult.success(
          data: data,
          statusCode: response.statusCode,
          headers: response.headers,
        );
      } else {
        return NetworkResult.failure(
          error: 'Upload failed: ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResult.failure(
        error: 'Upload error: ${_getErrorMessage(e)}',
        statusCode: 0,
      );
    }
  }

  /// 下载文件
  Future<NetworkResult<String>> downloadFile(
    String url,
    String savePath, {
    Map<String, String>? headers,
    void Function(int received, int total)? onProgress,
  }) async {
    try {
      final uri = Uri.parse(url);
      final request = http.Request('GET', uri);
      
      request.headers.addAll({
        ..._config.defaultHeaders,
        ...?headers,
      });
      
      if (_config.enableLogging) {
        debugPrint('[DOWNLOAD] $uri');
      }
      
      final streamedResponse = await _client.send(request).timeout(_config.timeout);
      
      if (streamedResponse.statusCode >= 200 && streamedResponse.statusCode < 300) {
        final file = File(savePath);
        await file.parent.create(recursive: true);
        
        final sink = file.openWrite();
        int received = 0;
        final total = streamedResponse.contentLength ?? 0;
        
        await for (final chunk in streamedResponse.stream) {
          sink.add(chunk);
          received += chunk.length;
          onProgress?.call(received, total);
        }
        
        await sink.close();
        
        if (_config.enableLogging) {
          debugPrint('Download completed: $savePath');
        }
        
        return NetworkResult.success(data: savePath);
      } else {
        return NetworkResult.failure(
          error: 'Download failed: HTTP ${streamedResponse.statusCode}',
          statusCode: streamedResponse.statusCode,
        );
      }
    } catch (e) {
      return NetworkResult.failure(
        error: 'Download error: ${_getErrorMessage(e)}',
        statusCode: 0,
      );
    }
  }

  /// 取消所有请求
  void cancelAllRequests() {
    _client.close();
    _client = http.Client();
  }

  /// 销毁网络管理器
  void dispose() {
    _statusCheckTimer?.cancel();
    _statusController.close();
    _client.close();
  }
}

/// 网络管理器扩展
extension NetworkManagerExtension on NetworkManager {
  /// 批量请求
  Future<List<NetworkResult<T>>> batchRequests<T>(
    List<Future<NetworkResult<T>>> requests, {
    int? concurrency,
  }) async {
    if (concurrency == null || concurrency >= requests.length) {
      return await Future.wait(requests);
    }
    
    final results = <NetworkResult<T>>[];
    
    for (int i = 0; i < requests.length; i += concurrency) {
      final batch = requests.skip(i).take(concurrency);
      final batchResults = await Future.wait(batch);
      results.addAll(batchResults);
    }
    
    return results;
  }
  
  /// 带缓存的GET请求
  Future<NetworkResult<T>> getCached<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
    Duration? cacheDuration,
    bool forceRefresh = false,
  }) async {
    // 这里可以集成缓存管理器
    // 实现缓存逻辑
    return get<T>(
      endpoint,
      headers: headers,
      queryParameters: queryParameters,
      fromJson: fromJson,
    );
  }
}