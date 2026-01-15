import '../core/api/api_client.dart';
import '../core/api/api_config.dart';
import '../models/user_profile.dart';

/// Service for user profile API operations
class UserService {
  final ApiClient _client;

  UserService(this._client);

  /// Get current user profile
  Future<UserProfile?> getCurrentUser() async {
    final response = await _client.get<Map<String, dynamic>>(
      '${ApiConfig.users}/me',
      fromJsonT: (data) => data as Map<String, dynamic>,
    );

    if (response.data != null) {
      return UserProfile.fromJson(response.data!);
    }
    return null;
  }

  /// Update user profile
  Future<UserProfile?> updateProfile({
    String? nickname,
    String? phone,
    String? gender,
    DateTime? birthdate,
  }) async {
    final body = <String, dynamic>{};
    if (nickname != null) body['nickname'] = nickname;
    if (phone != null) body['phone'] = phone;
    if (gender != null) body['gender'] = gender;
    if (birthdate != null) body['birthdate'] = birthdate.toIso8601String();

    final response = await _client.put<Map<String, dynamic>>(
      '${ApiConfig.users}/me',
      body: body,
      fromJsonT: (data) => data as Map<String, dynamic>,
    );

    if (response.data != null) {
      return UserProfile.fromJson(response.data!);
    }
    return null;
  }

  /// Update user avatar
  Future<String?> updateAvatar(String filePath) async {
    final response = await _client.uploadFile<Map<String, dynamic>>(
      '${ApiConfig.users}/me/avatar',
      filePath: filePath,
      fieldName: 'avatar',
      fromJsonT: (data) => data as Map<String, dynamic>,
    );

    if (response.data != null) {
      return response.data!['avatar_url'] as String?;
    }
    return null;
  }

  /// Get user statistics
  Future<Map<String, int>> getUserStats() async {
    final response = await _client.get<Map<String, dynamic>>(
      '${ApiConfig.users}/me/stats',
      fromJsonT: (data) => data as Map<String, dynamic>,
    );

    if (response.data != null) {
      return response.data!.map((key, value) => MapEntry(key, value as int));
    }
    return {};
  }
}
