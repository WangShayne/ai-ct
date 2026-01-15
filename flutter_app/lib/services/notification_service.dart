import '../core/api/api_client.dart';
import '../core/api/api_config.dart';
import '../models/notification.dart';

/// Service for notification API operations
class NotificationService {
  final ApiClient _client;

  NotificationService(this._client);

  /// Get all notifications for current user
  Future<List<AppNotification>> getNotifications({
    int page = 1,
    int limit = 20,
    String? type,
    bool? unreadOnly,
  }) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
    };
    if (type != null) {
      queryParams['type'] = type;
    }
    if (unreadOnly == true) {
      queryParams['unread'] = 'true';
    }

    final response = await _client.get<List<dynamic>>(
      ApiConfig.notifications,
      queryParams: queryParams,
      fromJsonT: (data) => data as List<dynamic>,
    );

    if (response.data != null) {
      return response.data!
          .map((json) => AppNotification.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Get unread notification count
  Future<int> getUnreadCount() async {
    final response = await _client.get<Map<String, dynamic>>(
      '${ApiConfig.notifications}/unread-count',
      fromJsonT: (data) => data as Map<String, dynamic>,
    );

    if (response.data != null) {
      return response.data!['count'] as int? ?? 0;
    }
    return 0;
  }

  /// Mark notification as read
  Future<bool> markAsRead(String id) async {
    final response = await _client.put(
      '${ApiConfig.notifications}/$id/read',
    );
    return response.success;
  }

  /// Mark all notifications as read
  Future<bool> markAllAsRead() async {
    final response = await _client.put(
      '${ApiConfig.notifications}/read-all',
    );
    return response.success;
  }

  /// Delete a notification
  Future<bool> deleteNotification(String id) async {
    final response = await _client.delete('${ApiConfig.notifications}/$id');
    return response.success;
  }

  /// Get notifications grouped by date
  Future<Map<String, List<AppNotification>>> getNotificationsGroupedByDate() async {
    final notifications = await getNotifications(limit: 100);
    final grouped = <String, List<AppNotification>>{};

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (final notification in notifications) {
      final notifDate = DateTime(
        notification.createdAt.year,
        notification.createdAt.month,
        notification.createdAt.day,
      );

      String dateKey;
      if (notifDate == today) {
        dateKey = '今日';
      } else if (notifDate == yesterday) {
        dateKey = '昨天';
      } else {
        dateKey = '${notifDate.month}月${notifDate.day}日';
      }

      grouped.putIfAbsent(dateKey, () => []);
      grouped[dateKey]!.add(notification);
    }

    return grouped;
  }
}
