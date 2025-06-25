import 'membership.dart';

class User {
  final String id;
  String name;
  String email;
  String phone;
  Membership? membership;
  List<DateTime> attendanceHistory;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.membership,
    List<DateTime>? attendanceHistory,
  }) : attendanceHistory = attendanceHistory ?? [];

  void updateProfile({String? name, String? email, String? phone}) {
    if (name != null) this.name = name;
    if (email != null) this.email = email;
    if (phone != null) this.phone = phone;
  }

  bool get hasActiveMembership => membership?.isActive ?? false;

  void addAttendance(DateTime date) {
    attendanceHistory.add(date);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      membership: json['membership'] != null
          ? Membership.fromJson(json['membership'] as Map<String, dynamic>)
          : null,
      attendanceHistory: (json['attendanceHistory'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'membership': membership?.toJson(),
      'attendanceHistory': attendanceHistory.map((e) => e.toIso8601String()).toList(),
    };
  }
}
