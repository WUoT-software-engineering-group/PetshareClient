import 'package:pet_share/models/pet.dart';
import 'package:test/test.dart';
import 'package:pet_share/models/announcement.dart';

void main() {
  group('Announcement', () {
    final Map<String, dynamic> json = {
      'id': '123',
      'title': 'Test Announcement',
      'description': 'This is a test announcement',
      'creationDate': '2022-01-01T00:00:00.000Z',
      'closingDate': '2022-01-31T00:00:00.000Z',
      'lastUpdateDate': '2022-01-01T00:00:00.000Z',
      'status': 1,
      'pet': {
        "id": "id",
        "shelterID": "shelterID",
        "name": "name",
        "species": "species",
        "breed": "breed",
        "birthday": "2023-04-20T15:30:00.000Z",
        "description": "description",
        "photo": []
      },
      'author': {
        'id': '789',
        'userName': 'testuser',
        'phoneNumer': '1234567890',
        'email': 'testuser@example.com',
        'fullShelterName': null,
        'isAuthorized': true,
        'adress': {
          'street': '123 Test St',
          'city': 'Test City',
          'provice': 'Test Province',
          'postalCode': '12345',
          'country': 'Test Country'
        }
      }
    };

    final announcement = Announcement.fromJson(json);

    test('fromJson should return an instance of Announcement', () {
      expect(announcement, isInstanceOf<Announcement>());
    });

    test('id should match json input', () {
      expect(announcement.id, json['id']);
    });

    test('title should match json input', () {
      expect(announcement.title, json['title']);
    });

    test('description should match json input', () {
      expect(announcement.description, json['description']);
    });

    test('creationDate should match json input', () {
      expect(announcement.creationDate.toString(),
          DateTime.parse(json['creationDate']).toString());
    });

    test('closingDate should match json input', () {
      expect(announcement.closingDate!.toString(),
          DateTime.parse(json['closingDate']).toString());
    });

    test('lastUpdateDate should match json input', () {
      expect(announcement.lastUpdateDate.toString(),
          DateTime.parse(json['lastUpdateDate']).toString());
    });

    test('status should match json input', () {
      expect(announcement.status, json['status']);
    });

    test('pet should match json input', () {
      expect(announcement.pet, isInstanceOf<Pet>());
      expect(announcement.pet.id, json['pet']['id']);
      expect(announcement.pet.shelterID, json['pet']['shelterID']);
      expect(announcement.pet.name, json['pet']['name']);
      expect(announcement.pet.species, json['pet']['species']);
      expect(announcement.pet.breed, json['pet']['breed']);
      expect(
          announcement.pet.birthday.toIso8601String(), json['pet']['birthday']);
      expect(announcement.pet.description, json['pet']['description']);
      expect(announcement.pet.photo, json['pet']['photo']);
    });

    test('author should match json input', () {
      expect(announcement.author, isInstanceOf<Author>());
      expect(announcement.author.id, json['author']['id']);
      expect(announcement.author.userName, json['author']['userName']);
      expect(announcement.author.phoneNumer, json['author']['phoneNumer']);
      expect(announcement.author.email, json['author']['email']);
      expect(announcement.author.fullShelterName,
          json['author']['fullShelterName']);
      expect(announcement.author.isAuthorized, json['author']['isAuthorized']);
    });
  });
}
