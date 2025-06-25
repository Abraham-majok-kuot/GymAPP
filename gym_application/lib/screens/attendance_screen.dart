import 'package:flutter/material.dart';

// Dummy member list for attendance
final List<String> members = [
  'Alice',
  'Bob',
  'Carol',
  'David',
  'Eve',
  'Frank',
];

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // Track attendance status for each member
  late List<bool> attendance;

  @override
  void initState() {
    super.initState();
    attendance = List<bool>.filled(members.length, false);
  }

  int get presentCount => attendance.where((a) => a).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(members[index]),
                  trailing: Checkbox(
                    value: attendance[index],
                    onChanged: (val) {
                      setState(() {
                        attendance[index] = val ?? false;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Present: $presentCount / ${members.length}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}