import 'package:insurance_claim/features/claims/data/models/claim.dart';
import 'package:insurance_claim/features/claims/data/services/claim_services.dart';


abstract class ClaimRepository {
  Future<List<Claim>> getClaims();
}

class ClaimRepositoryImpl implements ClaimRepository {
  final IClaimService service;
  ClaimRepositoryImpl(this.service);

  @override
  Future<List<Claim>> getClaims() => service.fetchClaims();
}

