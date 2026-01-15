enum RecordStatus { completed, processing, attention, normal }

class Record {
  final String id;
  final String title;
  final String date;
  final String time;
  final String type;
  final String? thumbnail;
  final RecordStatus status;
  final String statusLabel;
  
  const Record({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.type,
    this.thumbnail,
    required this.status,
    required this.statusLabel,
  });
  
  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'] as String,
      title: json['title'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      type: json['type'] as String,
      thumbnail: json['thumbnail'] as String?,
      status: RecordStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => RecordStatus.normal,
      ),
      statusLabel: json['status_label'] as String,
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'date': date,
    'time': time,
    'type': type,
    'thumbnail': thumbnail,
    'status': status.name,
    'status_label': statusLabel,
  };
}
