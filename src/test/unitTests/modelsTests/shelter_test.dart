import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/models/shelter.dart';

void main() {
  group('Shelter model', () {
    test('fromJson creates a Shelter object', () {
      // Arrange
      final json = {
        'username': 'testuser',
        'phoneNumber': '123-456-7890',
        'email': 'testuser@example.com',
        'fullShelterName': 'Test Shelter',
        'address': {
          'street': '123 Test St',
          'city': 'Test City',
          'provice': 'Test Province',
          'postalCode': '12345',
          'country': 'Test Country',
        },
      };

      final shelter = Shelter.fromJson(json);

      expect(shelter, isA<Shelter>());
      expect(shelter.userName, equals('testuser'));
      expect(shelter.phoneNumber, equals('123-456-7890'));
      expect(shelter.email, equals('testuser@example.com'));
      expect(shelter.fullShelterName, equals('Test Shelter'));
      expect(shelter.address, isA<Address>());
      expect(shelter.address.street, equals('123 Test St'));
      expect(shelter.address.city, equals('Test City'));
      expect(shelter.address.provice, equals('Test Province'));
      expect(shelter.address.postalCode, equals('12345'));
      expect(shelter.address.country, equals('Test Country'));
    });

    test('toJson creates a JSON string', () {
      final shelter = Shelter(
        userName: 'testuser',
        phoneNumber: '123-456-7890',
        email: 'testuser@example.com',
        fullShelterName: 'Test Shelter',
        address: Address(
          street: '123 Test St',
          city: 'Test City',
          provice: 'Test Province',
          postalCode: '12345',
          country: 'Test Country',
        ),
      );

      final jsonString = shelter.toJson();

      expect(jsonString, isA<String>());
      expect(
          jsonDecode(jsonString),
          equals({
            'userName': 'testuser',
            'phoneNumber': '123-456-7890',
            'email': 'testuser@example.com',
            'fullShelterName': 'Test Shelter',
            'address': {
              'street': '123 Test St',
              'city': 'Test City',
              'province': 'Test Province',
              'postalCode': '12345',
              'country': 'Test Country',
            },
          }));
    });
  });
}
