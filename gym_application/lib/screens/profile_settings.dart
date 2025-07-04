import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  String _profilePictureBase64 = '';
  String _initialLetter = 'U';
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final data = doc.data();
      setState(() {
        _profilePictureBase64 = data?['profilePicture'] ?? '';
        final name = data?['name'] ?? 'User';
        _initialLetter = name.isNotEmpty ? name[0].toUpperCase() : 'U';
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(bytes);
      setState(() {
        _profilePictureBase64 = base64Image;
      });
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'profilePicture': base64Image});
      }
    }
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null || user.email == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please provide the email')),
        );
        return;
      }
      try {
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: _currentPasswordController.text,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(_newPasswordController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password updated successfully')),
        );
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please provide the right password')),
          );
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  Future<void> _sendPasswordResetEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.email == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No user email found')));
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: user.email!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent. Check your inbox.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  void _showProfilePicturePreview(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black54, // Semi-transparent background
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) => Center(
        child: Material(
          type: MaterialType
              .transparency, // Transparent material to avoid square background
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white,
                backgroundImage: _profilePictureBase64.isNotEmpty
                    ? MemoryImage(base64Decode(_profilePictureBase64))
                    : null,
                child: _profilePictureBase64.isEmpty
                    ? Text(
                        _initialLetter,
                        style: const TextStyle(
                          fontSize: 48,
                          color: Color(0xFF800000),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Color(0xFF800000), fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Settings')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _showProfilePicturePreview(context),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  backgroundImage: _profilePictureBase64.isNotEmpty
                      ? MemoryImage(base64Decode(_profilePictureBase64))
                      : null,
                  child: _profilePictureBase64.isEmpty
                      ? Text(
                          _initialLetter,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Color(0xFF800000),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.edit, color: Colors.blue),
                label: const Text(
                  'Edit Profile Picture',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _currentPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Current Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your current password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _newPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'New Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a new password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        if (!RegExp(
                          r'^(?=.*[A-Za-z])(?=.*\d)',
                        ).hasMatch(value)) {
                          return 'Password must contain at least one letter and one number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Confirm New Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your new password';
                        }
                        if (value != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _changePassword,
                      child: const Text('Update Password'),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: _sendPasswordResetEmail,
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
