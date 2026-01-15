enum NotificationType { report, system, health }

class AppNotification {
  final int id;
  final String title;
  final String description;
  final String time;
  final NotificationType type;
  final bool read;
  
  const AppNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    required this.read,
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
      read: json['read'] as bool,
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'time': time,
    'type': type.name,
    'read': read,
  };
}
