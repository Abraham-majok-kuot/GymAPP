import 'package:flutter/material.dart';
import 'screens/membership_screen.dart';
import 'screens/class_scheduling_screen.dart';
import 'screens/dashboard_screen.dart'; // Import your dashboard screen
import 'screens/login_screen.dart'; // Import login screen
import 'screens/registration_screen.dart'; // Import registration screen

void main() {
  runApp(GymApp()); // Remove const here
}

class GymApp extends StatefulWidget {
  const GymApp({super.key});

  @override
  State<GymApp> createState() => _GymAppState();
}

class _GymAppState extends State<GymApp> {
  bool _darkMode = true; // Default is dark mode

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Management',
      debugShowCheckedModeBanner: false, // Removes the debug banner
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _darkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/login', // Set initial route to login
      routes: {
        '/login': (context) => const LoginScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/dashboard': (context) => DashboardScreen(
          darkModeEnabled: _darkMode,
          onDarkModeChanged: (val) {
            setState(() {
              _darkMode = val;
            });
          },
        ),
      },
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
