import 'package:flutter/material.dart';
import '../models/membership.dart';

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

  Widget buildMembershipCard(
    Membership membership,
    bool isSelected,
    bool isDarkMode,
  ) {
    final backgroundColor = isDarkMode ? const Color(0xFF800000) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final buttonColor = isDarkMode
        ? const Color(0xFFA00000)
        : const Color(0xFFB71C1C);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
            : null,
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              membership.type,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(membership.price, style: TextStyle(color: textColor)),
            const SizedBox(height: 8),
            Text(
              "Duration: ${membership.durationDays} days",
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 8),
            Text(
              "Status: ${membership.status.name}",
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(buttonColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(
                    buttonColor.withOpacity(0.2),
                  ),
                ),
                onPressed: () => selectMembership(membership),
                child: const Text('Select'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Membership Plans'),
        actions: [Padding(padding: const EdgeInsets.only(right: 16.0))],
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: memberships.length,
              itemBuilder: (context, index) {
                final membership = memberships[index];
                final isSelected = selectedMembership == membership;
                return buildMembershipCard(membership, isSelected, isDarkMode);
              },
            ),
          ),
        ],
      ),
    );
  }
}
