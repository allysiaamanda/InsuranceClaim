import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insurance_claim/main.dart';

void main() {
  testWidgets('Claims list page smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: ClaimsApp(),
      ),
    );

    // Wait for initial load
    await tester.pumpAndSettle();

    // You can add specific finds here if you want to verify the list.
    expect(find.textContaining('Claim'), findsWidgets);
  });
}
