import 'package:flutter/material.dart';
import 'screens/membership_screen.dart';
import 'screens/class_scheduling_screen.dart';
import 'screens/dashboard_screen.dart'; // Import your dashboard screen

void main() {
  runApp(const GymApp());
}

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Management',
      debugShowCheckedModeBanner: false, // Removes the debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DashboardScreen(), // Set DashboardScreen as the entry screen
    );
  }
}

class GymHomeScreen extends StatelessWidget {
  const GymHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/gymlogo.jpg', height: 32),
            const SizedBox(width: 10),
            const Text('Gym Management Home'),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Membership Plans'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MembershipScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Class Scheduling'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ClassSchedulingScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
