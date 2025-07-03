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
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${membership.type} Membership',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Price: ${membership.price}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Duration: ${membership.durationDays} days',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Features:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            ...membership.features.map((f) => Text('- $f')),
            const SizedBox(height: 16),
            Text(
              'Status: ${membership.status.name[0].toUpperCase()}${membership.status.name.substring(1)}',
              style: TextStyle(
                color: membership.status == MembershipStatus.active
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Membership Plans'),
        actions: [Padding(padding: const EdgeInsets.only(right: 16.0))],
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
