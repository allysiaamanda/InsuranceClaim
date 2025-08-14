import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_claim/features/claims/views/pages/claim_list_page.dart';
import 'package:insurance_claim/features/claims/views/provider/claim_notifier.dart';

void main() {
  runApp(const ProviderScope(child: ClaimsApp()));
}

class ClaimsApp extends ConsumerStatefulWidget {
  const ClaimsApp({super.key});

  @override
  ConsumerState<ClaimsApp> createState() => _ClaimsAppState();
}

class _ClaimsAppState extends ConsumerState<ClaimsApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(claimNotifierProvider.notifier).load());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Claims',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const ClaimsListPage(),
    );
  }
}
