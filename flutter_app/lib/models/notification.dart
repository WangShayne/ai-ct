enum NotificationType { report, system, health }

class AppNotification {
  final int id;
  final String title;
  final String description;
  final String time;
  final NotificationType type;
  final bool read;
  final DateTime createdAt;
  
  const AppNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    required this.read,
    required this.createdAt,
  });
  
  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      time: json['time'] as String,
      type: NotificationType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => NotificationType.system,
      ),
      read: json['read'] as bool? ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'time': time,
    'type': type.name,
    'read': read,
    'created_at': createdAt.toIso8601String(),
  };

  /// Create a copy with updated fields
  AppNotification copyWith({
    int? id,
    String? title,
    String? description,
    String? time,
    NotificationType? type,
    bool? read,
    DateTime? createdAt,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      type: type ?? this.type,
      read: read ?? this.read,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
