import 'package:flutter_test/flutter_test.dart';
import 'package:pet_share/models/address.dart';

Map<String, dynamic> json = {
  'street': '123 Test St',
  'city': 'Test City',
  'provice': 'Test Province',
  'postalCode': '12345',
  'country': 'Test Country',
};

Map<String, dynamic> nullJson = {
  'street': null,
  'city': null,
  'provice': null,
  'postalCode': null,
  'country': null,
};

void main() {
  group('Address', () {
    test('fromJson() should return an Address object', () {
      final address = Address2.fromJson(json);
      expect(address, isInstanceOf<Address2>());
      expect(address.street, json['street']);
      expect(address.city, json['city']);
      expect(address.provice, json['provice']);
      expect(address.postalCode, json['postalCode']);
      expect(address.country, json['country']);
    });

    test(
        'fromJson() that is working on null values should return Address object',
        () {
      final address = Address2.fromJson(nullJson);
      expect(address, isInstanceOf<Address2>());
    });
  });
}
