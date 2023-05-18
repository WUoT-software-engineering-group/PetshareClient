import 'package:flutter_test/flutter_test.dart';
import 'package:pet_share/models/address.dart';
import 'package:pet_share/models/adopter.dart';

Map<String, dynamic> json = {
  'id': '22',
  'userName': 'testuser',
  'phoneNumber': '1234567890',
  'email': 'testuser@example.com',
  'address': {
    'street': '123 Test St',
    'city': 'Test City',
    'provice': 'Test Province',
    'postalCode': '12345',
    'country': 'Test Country',
  },
  'status': 1
};

Map<String, dynamic> nullJson = {
  'id': null,
  'userName': null,
  'phoneNumber': null,
  'email': null,
  'address': {
    'street': null,
    'city': null,
    'provice': null,
    'postalCode': null,
    'country': null,
  },
  'status': null
};

void main() {
  group('Adopter', () {
    test('fromJson() should return an Adopter object', () {
      final adopter = Adopter2.fromJson(json);
      expect(adopter, isInstanceOf<Adopter2>());
      expect(adopter.userName, json['userName']);
      expect(adopter.phoneNumber, json['phoneNumber']);
      expect(adopter.email, json['email']);
      expect(adopter.address, isInstanceOf<Address2>());
    });

    test('fromJson with null values should parse object correctly', () {
      final adopter = Adopter2.fromJson(nullJson);
      expect(adopter, isInstanceOf<Adopter2>());
    });
  });
}
