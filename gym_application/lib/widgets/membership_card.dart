import 'package:flutter/material.dart';
import '../models/membership.dart';

class MembershipCard extends StatelessWidget {
  final Membership membership;
  final VoidCallback onSelect;
  final bool isSelected;

  const MembershipCard({
    super.key,
    required this.membership,
    required this.onSelect,
    required this.isSelected,
    Color? backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.green[50] : null,
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              membership.type,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              membership.price,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.green[700]),
            ),
            const SizedBox(height: 8),
            Text('Features:', style: Theme.of(context).textTheme.bodyMedium),
            ...membership.features.map(
              (feature) => Row(
                children: [
                  const Icon(Icons.check, color: Colors.green, size: 18),
                  const SizedBox(width: 6),
                  Text(feature),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onSelect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected ? Colors.green : null,
                ),
                child: Text(isSelected ? 'Selected' : 'Select'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
