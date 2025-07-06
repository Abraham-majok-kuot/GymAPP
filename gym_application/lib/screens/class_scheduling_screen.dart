import 'package:flutter/material.dart';

class ClassSchedule {
  final String className;
  final String instructor;
  final DateTime dateTime;
  final int slots;
  int bookedSlots;

  ClassSchedule({
    required this.className,
    required this.instructor,
    required this.dateTime,
    required this.slots,
    this.bookedSlots = 0,
  });
}

class ClassSchedulingScreen extends StatefulWidget {
  const ClassSchedulingScreen({super.key});

  @override
  State<ClassSchedulingScreen> createState() => _ClassSchedulingScreenState();
}

class _ClassSchedulingScreenState extends State<ClassSchedulingScreen> {
  final List<ClassSchedule> classes = [
    ClassSchedule(
      className: "Yoga",
      instructor: "Alice",
      dateTime: DateTime.now().add(const Duration(hours: 2)),
      slots: 10,
    ),
    ClassSchedule(
      className: "HIIT",
      instructor: "Bob",
      dateTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
      slots: 8,
    ),
    ClassSchedule(
      className: "Zumba",
      instructor: "Carol",
      dateTime: DateTime.now().add(const Duration(days: 2, hours: 3)),
      slots: 12,
    ),
  ];

  void bookSlot(int index) {
    setState(() {
      if (classes[index].bookedSlots < classes[index].slots) {
        classes[index].bookedSlots++;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Booked a slot for ${classes[index].className}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No slots available for ${classes[index].className}'),
          ),
        );
      }
    });
  }

  Future<void> _confirmAndBookSlot(int index) async {
    final classSchedule = classes[index];
    final shouldBook = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book Class'),
        content: Text(
          'Do you want to book a slot for ${classSchedule.className} with ${classSchedule.instructor} on ${_formatDateTime(classSchedule.dateTime)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    if (shouldBook == true) {
      bookSlot(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Scheduling'),
        backgroundColor: const Color.fromARGB(255, 129, 21, 21),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final classSchedule = classes[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                classSchedule.className,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Instructor: ${classSchedule.instructor}'),
                  Text('Date: ${_formatDateTime(classSchedule.dateTime)}'),
                  Text(
                    'Slots: ${classSchedule.bookedSlots}/${classSchedule.slots}',
                  ),
                ],
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF800000), // Maroon color
                ),
                onPressed: classSchedule.bookedSlots < classSchedule.slots
                    ? () => _confirmAndBookSlot(index)
                    : null,
                child: const Text('Book'),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} "
        "${dateTime.hour.toString().padLeft(2, '0')}:"
        "${dateTime.minute.toString().padLeft(2, '0')}";
  }
}
