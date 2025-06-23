import 'package:flutter/material.dart';
import 'membership_screen.dart';
import 'class_scheduling_screen.dart';
import 'settings_screen.dart';
import 'attendance_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    DashboardContent(),
    MembershipScreen(),
    ClassSchedulingScreen(),
    AttendanceScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black26,
        title: Row(
          children: [
            Hero(
              tag: 'gym_logo',
              child: Image.asset(
                'assets/images/gymlogo.jpg',
                height: 36,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.fitness_center,
                  size: 36,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Gym Dashboard',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications Coming Soon')),
              );
            },
            tooltip: 'Notifications',
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Text(
                'J',
                style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_membership),
            label: 'Membership',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Classes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8,
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Banner
          Container(
            height: 180,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Semantics(
                    label: 'Join our new yoga class promotion',
                    child: const Text(
                      'Join Our New Yoga Class!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ClassSchedulingScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text('Book Now'),
                  ),
                ],
              ),
            ),
          ),

          // Welcome Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Semantics(
              label: 'Welcome message for user',
              child: const Text(
                'Welcome Back, John!',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: .2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Your gym overview.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 20),

          // Quick Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildActionChip(context, 'Book Class', Icons.schedule, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ClassSchedulingScreen()));
                }),
                _buildActionChip(context, 'Renew Membership', Icons.card_membership, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MembershipScreen()));
                }),
                _buildActionChip(context, 'Check In', Icons.check_circle, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AttendanceScreen()));
                }),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Membership Status Card
          _buildCard(
            context,
            icon: Icons.card_membership,
            title: 'Membership Status',
            subtitle: 'Active until Dec 31, 2025',
            semanticsLabel: 'Membership status, active until December 31, 2025',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MembershipScreen())),
          ),

          // Upcoming Classes Card
          _buildCard(
            context,
            icon: Icons.schedule,
            title: 'Upcoming Classes',
            subtitle: 'Yoga - Tomorrow, 8 AM',
            semanticsLabel: 'Upcoming yoga class tomorrow at 8 AM',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ClassSchedulingScreen())),
          ),

          // Attendance Card
          _buildCard(
            context,
            icon: Icons.check_circle,
            title: 'Attendance',
            subtitle: 'Last visit: Jun 22, 2025',
            semanticsLabel: 'Last gym visit on June 22, 2025',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AttendanceScreen())),
          ),

          // Trainer Spotlight
          _buildCard(
            context,
            iconWidget: const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.deepPurple,
              child: Text('S', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            title: 'Meet Sarah',
            subtitle: 'Yoga & Strength Trainer',
            semanticsLabel: 'Featured trainer Sarah, specializes in yoga',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Trainer Profile Coming Soon')),
              );
            },
          ),

          // Gym Info Footer
          Padding(
            padding: const EdgeInsets.all(20),
            child: Semantics(
              label: 'Gym information',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gym Info',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('Hours: Mon-Fri 6 AM - 10 PM'),
                  const Text('Location: 123 Fitness St, City'),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Contact Us Coming Soon')),
                      );
                    },
                    child: const Text('Contact: +123-456-7890'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    IconData? icon,
    Widget? iconWidget,
    required String title,
    required String subtitle,
    required String semanticsLabel,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Semantics(
        label: semanticsLabel,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: iconWidget ?? Icon(icon, color: Colors.deepPurple, size: 30),
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(subtitle),
            trailing: const Icon(Icons.arrow_forward, color: Colors.deepPurple),
            onTap: onTap,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
      ),
    );
  }

  Widget _buildActionChip(BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    return ActionChip(
      avatar: Icon(icon, color: Colors.deepPurple),
      label: Text(label),
      onPressed: onPressed,
      backgroundColor: Colors.deepPurple[50],
      labelStyle: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}