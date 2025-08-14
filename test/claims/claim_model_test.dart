import 'package:flutter_test/flutter_test.dart';
import 'package:insurance_claim/features/claims/data/models/claim.dart';

void main() {
  test('Claim model (fromJson/toJson)', () {
    final json = {
      'userId': 101,
      'id': 2001,
      'title': 'Vehicle damage',
      'body': 'Hit from behind at a traffic light...'
    };

    final c = Claim.fromJson(json);
    expect(c.userId, 101);
    expect(c.id, 2001);
    expect(c.title, 'Vehicle damage');
    expect(c.body, contains('Hit from behind'));

    final back = c.toJson();
    expect(back['userId'], 101);
    expect(back['id'], 2001);
  });
}
