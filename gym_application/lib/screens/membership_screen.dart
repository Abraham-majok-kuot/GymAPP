import 'package:flutter/material.dart';
import '../models/membership.dart';
import '../widgets/membership_card.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  Membership? selectedMembership;

  final List<Membership> memberships = [
    Membership(
      type: 'Basic',
      price: '\$30/month',
      features: ['Gym Access', 'Locker Room'],
      durationDays: 30,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 30)),
      status: MembershipStatus.active,
    ),
    Membership(
      type: 'Premium',
      price: '\$50/month',
      features: ['All Basic Features', 'Group Classes', 'Sauna Access'],
      durationDays: 30,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 30)),
      status: MembershipStatus.active,
    ),
    Membership(
      type: 'VIP',
      price: '\$80/month',
      features: ['All Premium Features', 'Personal Trainer', 'Nutrition Plan'],
      durationDays: 30,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 30)),
      status: MembershipStatus.active,
    ),
  ];

  void selectMembership(Membership membership) {
    setState(() {
      selectedMembership = membership;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected ${membership.type} Membership')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Membership Plans'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/images/gymlogo.jpg',
              height: 36,
              width: 36,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          // Optionally, you can remove the logo here if you only want it in the AppBar
          // Image.asset('assets/images/gymlogo.jpg', height: 100),
          // const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: memberships.length,
              itemBuilder: (context, index) {
                final membership = memberships[index];
                return MembershipCard(
                  membership: membership,
                  onSelect: () => selectMembership(membership),
                  isSelected: selectedMembership == membership,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
