import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:insurance_claim/features/claims/data/services/claim_services.dart';
import 'package:mocktail/mocktail.dart';

class _MockClient extends Mock implements http.Client {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  test('ClaimService returns list on 200', () async {
    final client = _MockClient();
    final service = ClaimService(client: client);

    when(() => client.get(any())).thenAnswer((_) async => http.Response(
          jsonEncode([
            {'userId': 1, 'id': 1, 'title': 't1', 'body': 'b1'},
            {'userId': 2, 'id': 2, 'title': 't2', 'body': 'b2'},
          ]),
          200,
        ));

    final list = await service.fetchClaims();
    expect(list.length, 2);
    expect(list.first.title, 't1');
  });

  test('ClaimService throws on non-200', () async {
    final client = _MockClient();
    final service = ClaimService(client: client);

    when(() => client.get(any())).thenAnswer((_) async => http.Response('nope', 500));

    expect(() => service.fetchClaims(), throwsA(isA<Exception>()));
  });
}
