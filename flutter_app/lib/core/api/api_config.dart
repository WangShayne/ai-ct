/// API configuration constants
class ApiConfig {
  /// Base URL for the API server
  /// In development, this points to localhost
  /// In production, update to your server URL
  static const String baseUrl = 'http://localhost:8000';
  
  /// API version prefix
  static const String apiPrefix = '/api/v1';
  
  /// Full API URL
  static String get apiUrl => '$baseUrl$apiPrefix';
  
  /// Endpoints
  static const String users = '/users';
  static const String records = '/records';
  static const String notifications = '/notifications';
  static const String feedback = '/feedback';
  static const String upload = '/upload';
  
  /// Timeout durations
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
