class ClassSchedule {
  final String id;
  String className;
  String instructor;
  DateTime dateTime;
  int durationMinutes;
  int slots;
  int bookedSlots;
  List<String> attendees; // List of user IDs
  String description;

  ClassSchedule({
    required this.id,
    required this.className,
    required this.instructor,
    required this.dateTime,
    required this.durationMinutes,
    required this.slots,
    this.bookedSlots = 0,
    List<String>? attendees,
    this.description = '',
  }) : attendees = attendees ?? [];

  bool get isFull => bookedSlots >= slots;

  bool bookSlot(String userId) {
    if (isFull || attendees.contains(userId)) return false;
    attendees.add(userId);
    bookedSlots++;
    return true;
  }

  factory ClassSchedule.fromJson(Map<String, dynamic> json) {
    return ClassSchedule(
      id: json['id'] as String,
      className: json['className'] as String,
      instructor: json['instructor'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      durationMinutes: json['durationMinutes'] as int,
      slots: json['slots'] as int,
      bookedSlots: json['bookedSlots'] as int? ?? 0,
      attendees: (json['attendees'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'className': className,
      'instructor': instructor,
      'dateTime': dateTime.toIso8601String(),
      'durationMinutes': durationMinutes,
      'slots': slots,
      'bookedSlots': bookedSlots,
      'attendees': attendees,
      'description': description,
    };
  }
}
