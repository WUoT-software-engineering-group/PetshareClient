import 'package:flutter_test/flutter_test.dart';
import 'package:pet_share/models/address.dart';
import 'package:pet_share/models/shelter.dart';

Map<String, dynamic> json = {
  'id': '1',
  'userName': 'testuser',
  'phoneNumber': '123-456-7890',
  'email': 'testuser@example.com',
  'fullShelterName': 'Test Shelter',
  'isAuthorized': true,
  'address': {
    'street': null,
    'city': null,
    'provice': null,
    'postalCode': null,
    'country': null,
  },
};

Map<String, dynamic> nullJson = {
  'id': null,
  'userName': null,
  'phoneNumber': null,
  'email': null,
  'fullShelterName': null,
  'isAuthorized': true,
  'address': {
    'street': null,
    'city': null,
    'provice': null,
    'postalCode': null,
    'country': null,
  },
};
void main() {
  group('Shelter', () {
    test('fromJson creates a Shelter object', () {
      final shelter = Shelter2.fromJson(json);

      expect(shelter, isInstanceOf<Shelter2>());
      expect(shelter.id, json['id']);
      expect(shelter.userName, json['userName']);
      expect(shelter.phoneNumber, json['phoneNumber']);
      expect(shelter.email, json['email']);
      expect(shelter.fullShelterName, json['fullShelterName']);
      expect(shelter.isAuthorized, json['isAuthorized']);
      expect(shelter.address, isInstanceOf<Address2>());
    });

    test('fromJson with null values creates a Shelter object', () {
      final shelter = Shelter2.fromJson(json);
      expect(shelter, isInstanceOf<Shelter2>());
    });
  });
}
