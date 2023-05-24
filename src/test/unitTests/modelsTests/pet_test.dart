import 'package:flutter_test/flutter_test.dart';
import 'package:pet_share/models/pet.dart';
import 'package:pet_share/models/shelter.dart';

Map<String, dynamic> json = {
  'id': '1',
  'shelter': {
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
  },
  'name': 'testName',
  'species': 'testSpecies',
  'breed': 'testBreed',
  'birthday': '2020-01-01T00:00:00.000',
  'description': 'testDescription',
  'photoUrl': 'testUrl',
  'status': 1,
  'sex': 1,
};

Map<String, dynamic> nullJson = {
  'id': null,
  'shelter': {
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
  },
  'name': null,
  'species': null,
  'breed': null,
  'birthday': null,
  'description': null,
  'photoUrl': null,
  'status': null,
  'sex': null,
};

void main() {
  group('Pet', () {
    test('fromJson should correctly parse a JSON object to pet', () {
      final pet = Pet2.fromJson(json);

      expect(pet, isInstanceOf<Pet2>());
      expect(pet.id, json['id']);
      expect(pet.shelter, isInstanceOf<Shelter2>());
      expect(pet.name, json['name']);
      expect(pet.species, json['species']);
      expect(pet.breed, json['breed']);
      expect(pet.birthday, DateTime.parse(json['birthday']));
      expect(pet.description, json['description']);
      expect(pet.photoUrl, json['photoUrl']);
      expect(pet.sex, Pet2.intToSex(json['sex']));
    });

    test(
        'fromJson with null values should correctly parse a JSON object to pet',
        () {
      final pet = Pet2.fromJson(nullJson);
      expect(pet, isInstanceOf<Pet2>());
    });

    test('intToSex should return correct values', () {
      expect(SexOfPet.unknown, Pet2.intToSex(0));
      expect(SexOfPet.male, Pet2.intToSex(1));
      expect(SexOfPet.female, Pet2.intToSex(2));
      expect(SexOfPet.unknown, Pet2.intToSex(null));
    });
  });
}
