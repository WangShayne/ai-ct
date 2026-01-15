import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'api_exception.dart';

/// Generic API response wrapper
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final int? code;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.code,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse(
      success: json['success'] ?? true,
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'],
      message: json['message'],
      code: json['code'],
    );
  }
}

/// HTTP client wrapper for API calls
class ApiClient {
  final http.Client _client;
  final String _baseUrl;
  String? _authToken;

  ApiClient({http.Client? client})
      : _client = client ?? http.Client(),
        _baseUrl = ApiConfig.apiUrl;

  /// Set authentication token
  void setAuthToken(String token) {
    _authToken = token;
  }

  /// Clear authentication token
  void clearAuthToken() {
    _authToken = null;
  }

  /// Build headers for requests
  Map<String, String> _buildHeaders({Map<String, String>? extra}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    
    if (extra != null) {
      headers.addAll(extra);
    }
    
    return headers;
  }

  /// Parse response and handle errors
  Future<ApiResponse<T>> _handleResponse<T>(
    http.Response response,
    T Function(dynamic)? fromJsonT,
  ) async {
    final statusCode = response.statusCode;
    
    if (statusCode >= 200 && statusCode < 300) {
      if (response.body.isEmpty) {
        return ApiResponse(success: true);
      }
      
      final json = jsonDecode(response.body);
      return ApiResponse.fromJson(json, fromJsonT);
    }
    
    // Handle error responses
    String message = 'Request failed';
    try {
      final json = jsonDecode(response.body);
      message = json['detail'] ?? json['message'] ?? message;
    } catch (_) {
      message = response.body.isNotEmpty ? response.body : message;
    }
    
    throw ApiException(
      statusCode: statusCode,
      message: message,
    );
  }

  /// GET request
  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, String>? queryParams,
    T Function(dynamic)? fromJsonT,
  }) async {
    try {
      var uri = Uri.parse('$_baseUrl$endpoint');
      if (queryParams != null) {
        uri = uri.replace(queryParameters: queryParams);
      }

      final response = await _client
          .get(uri, headers: _buildHeaders())
          .timeout(ApiConfig.connectTimeout);

      return _handleResponse(response, fromJsonT);
    } on SocketException {
      throw ApiException(message: 'No internet connection');
    } on HttpException {
      throw ApiException(message: 'HTTP error occurred');
    }
  }

  /// POST request
  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    T Function(dynamic)? fromJsonT,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await _client
          .post(
            uri,
            headers: _buildHeaders(),
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(ApiConfig.connectTimeout);

      return _handleResponse(response, fromJsonT);
    } on SocketException {
      throw ApiException(message: 'No internet connection');
    } on HttpException {
      throw ApiException(message: 'HTTP error occurred');
    }
  }

  /// PUT request
  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    T Function(dynamic)? fromJsonT,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await _client
          .put(
            uri,
            headers: _buildHeaders(),
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(ApiConfig.connectTimeout);

      return _handleResponse(response, fromJsonT);
    } on SocketException {
      throw ApiException(message: 'No internet connection');
    } on HttpException {
      throw ApiException(message: 'HTTP error occurred');
    }
  }

  /// DELETE request
  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    T Function(dynamic)? fromJsonT,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await _client
          .delete(uri, headers: _buildHeaders())
          .timeout(ApiConfig.connectTimeout);

      return _handleResponse(response, fromJsonT);
    } on SocketException {
      throw ApiException(message: 'No internet connection');
    } on HttpException {
      throw ApiException(message: 'HTTP error occurred');
    }
  }

  /// Multipart file upload
  Future<ApiResponse<T>> uploadFile<T>(
    String endpoint, {
    required String filePath,
    required String fieldName,
    Map<String, String>? fields,
    T Function(dynamic)? fromJsonT,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final request = http.MultipartRequest('POST', uri);
      
      request.headers.addAll(_buildHeaders());
      request.files.add(await http.MultipartFile.fromPath(fieldName, filePath));
      
      if (fields != null) {
        request.fields.addAll(fields);
      }

      final streamedResponse = await request.send().timeout(ApiConfig.connectTimeout);
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response, fromJsonT);
    } on SocketException {
      throw ApiException(message: 'No internet connection');
    } on HttpException {
      throw ApiException(message: 'HTTP error occurred');
    }
  }

  /// Dispose client
  void dispose() {
    _client.close();
  }
}
