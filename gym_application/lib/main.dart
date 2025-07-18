import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/membership_screen.dart';
import 'screens/class_scheduling_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/profile_settings.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp(); // Removed App Check initialization
  runApp(const GymApp());
}

class GymApp extends StatefulWidget {
  const GymApp({super.key});

  @override
  State<GymApp> createState() => _GymAppState();
}

class _GymAppState extends State<GymApp> {
  bool _darkMode = true;

  void _onDarkModeChanged(bool value) {
    setState(() {
      _darkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _darkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/dashboard': (context) => DashboardScreen(
          darkModeEnabled: _darkMode,
          onDarkModeChanged: _onDarkModeChanged,
        ),
        '/home': (context) => const GymHomeScreen(),
        '/profile': (context) => const ProfileSettings(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => DashboardScreen(
          darkModeEnabled: _darkMode,
          onDarkModeChanged: _onDarkModeChanged,
        ),
      ),
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
            Image.asset(
              'assets/images/gymlogo.jpg',
              height: 32,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
            const SizedBox(width: 10),
            const Text('Gym Management Home'),
          ],
        ),
        backgroundColor: const Color(0xFF800000),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MembershipScreen(),
                  ),
                );
              },
              child: const Text('Membership Plans'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ClassSchedulingScreen(),
                  ),
                );
              },
              child: const Text('Class Scheduling'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileSettings(),
                  ),
                );
              },
              child: const Text('Profile Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
