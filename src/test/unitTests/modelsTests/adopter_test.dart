import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pet_share/models/adopter.dart';
import 'package:pet_share/models/announcement.dart';

void main() {
  group('Adopter', () {
    final json = {
      'username': 'JohnDoe',
      'phoneNumber': '1234567890',
      'email': 'johndoe@example.com',
      'address': {
        'street': '123 Test St',
        'city': 'Test City',
        'provice': 'Test Province',
        'postalCode': '12345',
        'country': 'Test Country',
      }
    };

    test('fromJson() should return an Adopter object', () {
      final adopter = Adopter.fromJson(json);

      expect(adopter, isInstanceOf<Adopter>());
      expect(adopter.userName, json['username']);
      expect(adopter.phoneNumber, json['phoneNumber']);
      expect(adopter.email, json['email']);
      expect(adopter.address, isInstanceOf<Address>());
    });
    test('toJson() should return a JSON string', () {
      final adopter = Adopter(
        userName: 'testuser',
        phoneNumber: '1234567890',
        email: 'testuser@example.com',
        address: Address(
          street: '123 Test St',
          city: 'Test City',
          provice: 'Test Province',
          postalCode: '12345',
          country: 'Test Country',
        ),
      );

      final jsonString = adopter.toJson();

      const expectedJsonString = '''
        {
          "userName":"testuser",
          "phoneNumber":"1234567890",
          "email":"testuser@example.com",
          "address":{
            "street":"123 Test St",
            "city":"Test City",
            "province":"Test Province",
            "postalCode":"12345",
            "country":"Test Country"
          }
        }
      ''';

      final expectedJson = jsonDecode(expectedJsonString);

      expect(jsonDecode(jsonString), expectedJson);
    });
  });
}
