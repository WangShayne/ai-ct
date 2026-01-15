import 'package:flutter/foundation.dart';
import '../core/api/api_client.dart';
import '../models/notification.dart';
import '../services/notification_service.dart';

/// Provider for managing notifications state
class NotificationProvider extends ChangeNotifier {
  final NotificationService _service;
  
  List<AppNotification> _notifications = [];
  Map<String, List<AppNotification>> _groupedNotifications = {};
  int _unreadCount = 0;
  bool _isLoading = false;
  String? _error;
  
  NotificationProvider(ApiClient client) : _service = NotificationService(client);
  
  // Getters
  List<AppNotification> get notifications => _notifications;
  Map<String, List<AppNotification>> get groupedNotifications => _groupedNotifications;
  int get unreadCount => _unreadCount;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasUnread => _unreadCount > 0;
  
  /// Load all notifications
  Future<void> loadNotifications() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _notifications = await _service.getNotifications();
      _unreadCount = _notifications.where((n) => !n.read).length;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Load notifications grouped by date
  Future<void> loadGroupedNotifications() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _groupedNotifications = await _service.getNotificationsGroupedByDate();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Refresh unread count
  Future<void> refreshUnreadCount() async {
    try {
      _unreadCount = await _service.getUnreadCount();
      notifyListeners();
    } catch (e) {
      debugPrint('Error refreshing unread count: $e');
    }
  }
  
  /// Mark a notification as read
  Future<void> markAsRead(String id) async {
    try {
      final success = await _service.markAsRead(id);
      if (success) {
        final index = _notifications.indexWhere((n) => n.id.toString() == id);
        if (index != -1) {
          _notifications[index] = _notifications[index].copyWith(read: true);
          _unreadCount = _notifications.where((n) => !n.read).length;
          notifyListeners();
        }
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
  
  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      final success = await _service.markAllAsRead();
      if (success) {
        _notifications = _notifications.map((n) => n.copyWith(read: true)).toList();
        _unreadCount = 0;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
  
  /// Delete a notification
  Future<bool> deleteNotification(String id) async {
    try {
      final success = await _service.deleteNotification(id);
      if (success) {
        _notifications.removeWhere((n) => n.id.toString() == id);
        _unreadCount = _notifications.where((n) => !n.read).length;
        notifyListeners();
      }
      return success;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  
  /// Clear all cached data
  void clear() {
    _notifications = [];
    _groupedNotifications = {};
    _unreadCount = 0;
    _error = null;
    notifyListeners();
  }
}
