import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        Navigator.pushReplacementNamed(context, '/dashboard');
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message ?? 'Login failed')));
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('An error occurred')));
      }
    }
  }

  Future<void> _sendPasswordResetEmail() async {
    final email = _emailController.text;
    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter your email')));
      return;
    }
    try {
      print('Sending reset email to: $email'); // Debug log
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent. Check your inbox.'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code}, ${e.message}'); // Debug log
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Invalid email address';
          break;
        case 'user-not-found':
          errorMessage = 'No user found for this email';
          break;
        default:
          errorMessage = e.message ?? 'Failed to send reset email';
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $errorMessage')));
    } catch (e) {
      print('General error: $e'); // Debug log
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800000),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/gymlogo.jpg', height: 80),
                  const SizedBox(height: 16),
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF800000),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      labelStyle: const TextStyle(color: Color(0xFF800000)),
                      errorStyle: const TextStyle(color: Colors.red),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.black),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      labelStyle: const TextStyle(color: Color(0xFF800000)),
                      errorStyle: const TextStyle(color: Colors.red),
                    ),
                    obscureText: true,
                    style: const TextStyle(color: Colors.black),
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF800000),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Login', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/registration');
                    },
                    child: const Text(
                      'Don\'t have an account? Sign up',
                      style: TextStyle(color: Color(0xFF800000)),
                    ),
                  ),
                  TextButton(
                    onPressed: _sendPasswordResetEmail,
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Color(0xFF800000)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
