
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insurance_claim/features/claims/data/models/claim.dart';
import 'package:insurance_claim/features/claims/data/services/claim_services.dart';
import 'package:insurance_claim/features/claims/views/pages/claim_list_page.dart';
import 'package:insurance_claim/features/claims/views/provider/claim_notifier.dart';

class _FakeService extends Fake implements IClaimService {
  @override
  Future<List<Claim>> fetchClaims() async => [
        const Claim(userId: 101, id: 2001, title: 'Vehicle damage', body: 'Rear-end'),
        const Claim(userId: 102, id: 2002, title: 'House fire', body: 'Kitchen'),
      ];
}

void main() {
  testWidgets('Shows list and navigates to detail', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          claimServiceProvider.overrideWithValue(_FakeService()),
        ],
        child: const MaterialApp(home: ClaimsListPage()),
      ),
    );

    // Trigger initial load
    final container = ProviderScope.containerOf(tester.element(find.byType(ClaimsListPage)));
    await container.read(claimNotifierProvider.notifier).load();

    await tester.pumpAndSettle();

    expect(find.text('Vehicle damage'), findsOneWidget);
    expect(find.text('House fire'), findsOneWidget);

    await tester.tap(find.text('Vehicle damage'));
    await tester.pumpAndSettle();

    expect(find.text('Claim #2001'), findsOneWidget);
    expect(find.text('Claimant ID: 101'), findsOneWidget);
  });
}
