import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
        backgroundColor: const Color(0xFF800000), // IUEA Maroon color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                labelStyle: const TextStyle(color: Color(0xFF800000)), // IUEA Maroon color
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                labelStyle: const TextStyle(color: Color(0xFF800000)), // IUEA Maroon color
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                labelStyle: const TextStyle(color: Color(0xFF800000)), // IUEA Maroon color
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
                labelStyle: const TextStyle(color: Color(0xFF800000)), // IUEA Maroon color
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard'); // Navigate to dashboard
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF800000), // IUEA Maroon color
              ),
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}