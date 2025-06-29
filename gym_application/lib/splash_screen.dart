import 'dart:async';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Correct import for LoginScreen from lib

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the login screen after 2 seconds using named route
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // Set text direction to left-to-right
      child: Scaffold(
        body: Container(
          color: const Color(0xFF7F2B34), // Maroon background
          child: Center(
            child: Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.cover, // Ensures the image covers the screen
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
