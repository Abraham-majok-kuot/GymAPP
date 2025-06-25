enum MembershipStatus { active, expired, pending }

class Membership {
  final String type;
  final String price;
  final List<String> features;
  final int durationDays; // Duration in days
  final DateTime startDate;
  final DateTime endDate;
  final MembershipStatus status;

  Membership({
    required this.type,
    required this.price,
    required this.features,
    required this.durationDays,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  bool get isActive => status == MembershipStatus.active && DateTime.now().isBefore(endDate);

  int get daysLeft {
    final now = DateTime.now();
    if (now.isAfter(endDate)) return 0;
    return endDate.difference(now).inDays;
  }

  String get formattedStartDate =>
      "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";
  String get formattedEndDate =>
      "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      type: json['type'] as String,
      price: json['price'] as String,
      features: List<String>.from(json['features'] as List),
      durationDays: json['durationDays'] as int,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      status: MembershipStatus.values.firstWhere(
        (e) => e.toString() == 'MembershipStatus.${json['status']}',
        orElse: () => MembershipStatus.pending,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'price': price,
      'features': features,
      'durationDays': durationDays,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status.name,
    };
  }
}
