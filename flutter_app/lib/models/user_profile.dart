class UserProfile {
  final String name;
  final String id;
  final int joinDays;
  final String? avatar;
  final String? avatarUrl;
  final String? gender;
  final String? birthday;
  final String? phone;
  final int? height;
  final int? weight;
  final String? bloodType;
  
  const UserProfile({
    required this.name,
    required this.id,
    required this.joinDays,
    this.avatar,
    this.avatarUrl,
    this.gender,
    this.birthday,
    this.phone,
    this.height,
    this.weight,
    this.bloodType,
  });
  
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
      joinDays: json['join_days'] as int? ?? 0,
      avatar: json['avatar'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      gender: json['gender'] as String?,
      birthday: json['birthday'] as String?,
      phone: json['phone'] as String?,
      height: json['height'] as int?,
      weight: json['weight'] as int?,
      bloodType: json['blood_type'] as String?,
    );
  }
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'join_days': joinDays,
    'avatar': avatar,
    'avatar_url': avatarUrl,
    'gender': gender,
    'birthday': birthday,
    'phone': phone,
    'height': height,
    'weight': weight,
    'blood_type': bloodType,
  };

  /// Create a copy with updated fields
  UserProfile copyWith({
    String? name,
    String? id,
    int? joinDays,
    String? avatar,
    String? avatarUrl,
    String? gender,
    String? birthday,
    String? phone,
    int? height,
    int? weight,
    String? bloodType,
  }) {
    return UserProfile(
      name: name ?? this.name,
      id: id ?? this.id,
      joinDays: joinDays ?? this.joinDays,
      avatar: avatar ?? this.avatar,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bloodType: bloodType ?? this.bloodType,
    );
  }
}
