enum AttendanceStatus { present, absent, late }

class Attendance {
  final String userId;
  final DateTime date;
  final AttendanceStatus status;
  final String? notes;

  Attendance({
    required this.userId,
    required this.date,
    required this.status,
    this.notes,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      userId: json['userId'] as String,
      date: DateTime.parse(json['date'] as String),
      status: AttendanceStatus.values.firstWhere(
        (e) => e.toString() == 'AttendanceStatus.${json['status']}',
        orElse: () => AttendanceStatus.absent,
      ),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date.toIso8601String(),
      'status': status.name,
      'notes': notes,
    };
  }
}
