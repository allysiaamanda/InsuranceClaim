import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_claim/features/claims/data/models/claim.dart';
import 'package:insurance_claim/features/claims/views/provider/claim_notifier.dart';

class ClaimsListPage extends ConsumerWidget {
  const ClaimsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(claimNotifierProvider);
    final items = ref.watch(filteredClaimsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Insurance Claims')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search (title, description, claim ID, claimant ID)',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (q) => ref.read(claimNotifierProvider.notifier).setQuery(q),
            ),
          ),
          if (state.isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (state.error != null)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.error!, textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => ref.read(claimNotifierProvider.notifier).load(),
                      child: const Text('Retry'),
                    )
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.read(claimNotifierProvider.notifier).load(),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, i) => _ClaimTile(claim: items[i]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ClaimTile extends StatelessWidget {
  final Claim claim;
  const _ClaimTile({required this.claim});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(claim.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          claim.body,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Claim #${claim.id}', style: const TextStyle(fontSize: 12)),
            Text('User #${claim.userId}', style: const TextStyle(fontSize: 12)),
          ],
        ),
        onTap: () {
          
        },
      ),
    );
  }
}
