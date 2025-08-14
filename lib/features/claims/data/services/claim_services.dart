import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:insurance_claim/core/network/exceptions.dart';
import 'package:insurance_claim/features/claims/data/models/claim.dart';

abstract class IClaimService {
  Future<List<Claim>> fetchClaims();
}

class ClaimService implements IClaimService {
  final http.Client client;
  ClaimService({http.Client? client}) : client = client ?? http.Client();

  static const _endpoint = 'https://jsonplaceholder.typicode.com/posts';

  @override
  Future<List<Claim>> fetchClaims() async {
    try {
      final res = await client.get(Uri.parse(_endpoint));
      if (res.statusCode == 200) {
        final list = jsonDecode(res.body) as List;
        return list.map((e) => Claim.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        throw NetworkException('Failed to load claims', statusCode: res.statusCode);
      }
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException('Unexpected error: $e');
    }
  }
}
