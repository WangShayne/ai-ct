class UserProfile {
  final String name;
  final String id;
  final int joinDays;
  final String? avatar;
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
    this.gender,
    this.birthday,
    this.phone,
    this.height,
    this.weight,
    this.bloodType,
  });
  
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] as String,
      id: json['id'] as String,
      joinDays: json['join_days'] as int,
      avatar: json['avatar'] as String?,
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
    'gender': gender,
    'birthday': birthday,
    'phone': phone,
    'height': height,
    'weight': weight,
    'blood_type': bloodType,
  };
}
