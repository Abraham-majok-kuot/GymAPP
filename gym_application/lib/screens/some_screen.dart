import '../models/user.dart';
import '../models/membership.dart';
import '../models/attendance.dart';
import '../models/class_schedule.dart';
import '../models/trainer.dart';

void main() {
  // Example: Creating a user and checking membership
  final currentUser = User(
    id: 'u1',
    name: 'Abraham',
    email: 'abrahammajok87@gmail.com',
    phone: '1234567890',
  );

  if (currentUser.hasActiveMembership) {
    // ...do something...
  }

  // Example: Adding attendance
  currentUser.addAttendance(DateTime.now());

  // Example: Creating a class schedule
  final classSchedule = ClassSchedule(
    id: 'c1',
    className: 'Yoga',
    instructor: 'Alice',
    dateTime: DateTime.now().add(Duration(days: 1)),
    durationMinutes: 60,
    slots: 10,
    bookedSlots: 0,
    attendees: [],
    description: 'Morning Yoga Class',
  );

  // Example: Creating a trainer
  final trainer = Trainer(
    id: 't1',
    name: 'Bob',
    specialty: 'Strength Training',
    bio: 'Expert in strength and conditioning.',
    photoUrl: '',
    rating: 4.5,
    classes: [],
  );

  // Example: Creating a membership
  final membership = Membership(
    type: 'Premium',
    price: '\$50',
    features: ['Access to all classes', 'Free water bottle'],
    durationDays: 30,
    startDate: DateTime.now(),
    endDate: DateTime.now().add(Duration(days: 30)),
    status: MembershipStatus.active,
  );

  // Example: Recording an attendance
  final attendance = Attendance(
    userId: currentUser.id,
    date: DateTime.now(),
    status: AttendanceStatus.present,
    notes: 'Arrived on time',
  );
}
