import 'package:flutter/material.dart';
import 'package:insurance_claim/features/claims/data/models/claim.dart';

class ClaimDetailPage extends StatelessWidget {
  final Claim claim;
  const ClaimDetailPage({super.key, required this.claim});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Claim #${claim.id}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(claim.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Claimant ID: ${claim.userId}'),
            const Divider(height: 24),
            Text(claim.body),
          ],
        ),
      ),
    );
  }
}
