import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insurance_claim/core/network/exceptions.dart';
import 'package:insurance_claim/features/claims/data/models/claim.dart';
import 'package:insurance_claim/features/claims/data/services/claim_services.dart';
import 'package:insurance_claim/features/claims/domain/repositories/claim_repository.dart';

final claimServiceProvider = Provider<IClaimService>((ref) => ClaimService());
final claimRepositoryProvider = Provider<ClaimRepositoryImpl>(
  (ref) => ClaimRepositoryImpl(ref.read(claimServiceProvider)),
);

class ClaimState {
  final List<Claim> items;
  final bool isLoading;
  final String? error;
  final String query;

  const ClaimState({
    this.items = const [],
    this.isLoading = false,
    this.error,
    this.query = '',
  });

  ClaimState copyWith({
    List<Claim>? items,
    bool? isLoading,
    String? error,
    String? query,
  }) =>
      ClaimState(
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading,
        error: error,
        query: query ?? this.query,
      );
}

class ClaimNotifier extends StateNotifier<ClaimState> {
  final ClaimRepositoryImpl repo;
  ClaimNotifier(this.repo) : super(const ClaimState());

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final data = await repo.getClaims();
      state = state.copyWith(items: data, isLoading: false);
    } on NetworkException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void setQuery(String q) => state = state.copyWith(query: q);

  List<Claim> get filtered {
    final q = state.query.trim().toLowerCase();
    if (q.isEmpty) return state.items;
    return state.items.where((c) {
      return c.title.toLowerCase().contains(q) ||
             c.body.toLowerCase().contains(q) ||
             c.id.toString() == q ||
             c.userId.toString() == q;
    }).toList();
  }
}

final claimNotifierProvider =
    StateNotifierProvider<ClaimNotifier, ClaimState>((ref) {
  final repo = ref.read(claimRepositoryProvider);
  return ClaimNotifier(repo);
});

// A derived provider for filtered list
final filteredClaimsProvider = Provider<List<Claim>>((ref) {
  final notifier = ref.watch(claimNotifierProvider.notifier);
  // watch base state to react to query/data changes
  ref.watch(claimNotifierProvider);
  return notifier.filtered;
});
