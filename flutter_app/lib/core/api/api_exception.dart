/// Custom exception for API errors
class ApiException implements Exception {
  final int? statusCode;
  final String message;

  ApiException({
    this.statusCode,
    required this.message,
  });

  @override
  String toString() => 'ApiException: [$statusCode] $message';

  /// Check if this is a network error
  bool get isNetworkError => statusCode == null;

  /// Check if this is an authentication error
  bool get isAuthError => statusCode == 401;

  /// Check if this is a not found error
  bool get isNotFound => statusCode == 404;

  /// Check if this is a server error
  bool get isServerError => statusCode != null && statusCode! >= 500;

  /// Check if this is a validation error
  bool get isValidationError => statusCode == 422;
}
