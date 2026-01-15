import 'package:flutter/foundation.dart';
import '../core/api/api_client.dart';
import '../models/user_profile.dart';
import '../services/user_service.dart';

/// Provider for managing user profile state
class UserProvider extends ChangeNotifier {
  final UserService _service;
  
  UserProfile? _user;
  Map<String, int> _stats = {};
  bool _isLoading = false;
  String? _error;
  
  UserProvider(ApiClient client) : _service = UserService(client);
  
  // Getters
  UserProfile? get user => _user;
  Map<String, int> get stats => _stats;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _user != null;
  
  /// Load current user profile
  Future<void> loadUser() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _user = await _service.getCurrentUser();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Load user statistics
  Future<void> loadStats() async {
    try {
      _stats = await _service.getUserStats();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading user stats: $e');
    }
  }
  
  /// Update user profile
  Future<bool> updateProfile({
    String? nickname,
    String? phone,
    String? gender,
    DateTime? birthdate,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final updated = await _service.updateProfile(
        nickname: nickname,
        phone: phone,
        gender: gender,
        birthdate: birthdate,
      );
      
      if (updated != null) {
        _user = updated;
        _error = null;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Update user avatar
  Future<bool> updateAvatar(String filePath) async {
    try {
      final avatarUrl = await _service.updateAvatar(filePath);
      if (avatarUrl != null && _user != null) {
        _user = _user!.copyWith(avatarUrl: avatarUrl);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  
  /// Logout - clear user data
  void logout() {
    _user = null;
    _stats = {};
    _error = null;
    notifyListeners();
  }
  
  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
