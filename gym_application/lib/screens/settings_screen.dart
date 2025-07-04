import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'profile_settings.dart';

class SettingsScreen extends StatefulWidget {
  final bool darkModeEnabled;
  final ValueChanged<bool> onDarkModeChanged;

  const SettingsScreen({
    super.key,
    required this.darkModeEnabled,
    required this.onDarkModeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  late bool _darkModeEnabled;

  @override
  void initState() {
    super.initState();
    _darkModeEnabled = widget.darkModeEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color.fromARGB(255, 114, 4, 6),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Preferences',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: _notificationsEnabled,
            onChanged: (val) {
              setState(() {
                _notificationsEnabled = val;
              });
            },
            secondary: const Icon(Icons.notifications),
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _darkModeEnabled,
            onChanged: (val) {
              setState(() {
                _darkModeEnabled = val;
              });
              widget.onDarkModeChanged(val);
            },
            secondary: const Icon(Icons.dark_mode),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Account',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileSettings(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Logged out')));
            },
          ),
        ],
      ),
    );
  }
}
