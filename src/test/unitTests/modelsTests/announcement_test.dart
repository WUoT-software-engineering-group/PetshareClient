import 'package:flutter_test/flutter_test.dart';
import 'package:pet_share/models/announcement.dart';

Map<String, dynamic> json = {
  'id': '123',
  'title': 'testTitle',
  'description': 'testDescription',
  'creationDate': '2022-01-01T00:00:00.000Z',
  'closingDate': '2022-01-31T00:00:00.000Z',
  'lastUpdateDate': '2022-01-01T00:00:00.000Z',
  'status': 1,
  'pet': {
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
  },
};

Map<String, dynamic> nullJson = {
  'id': null,
  'title': null,
  'description': null,
  'creationDate': null,
  'closingDate': null,
  'lastUpdateDate': null,
  'status': null,
  'pet': {
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
  },
};
void main() {
  group('Announcement', () {
    test('fromJson should correctly parse json to announcement object', () {
      final announcement = Announcement2.fromJson(json);
      expect(announcement, isInstanceOf<Announcement2>());
      expect(announcement.id, json['id']);
      expect(announcement.title, json['title']);
      expect(announcement.description, json['description']);
      expect(announcement.creationDate, DateTime.parse(json['creationDate']));
      expect(announcement.closingDate, DateTime.parse(json['closingDate']));
      expect(
          announcement.lastUpdateDate, DateTime.parse(json['lastUpdateDate']));
      expect(announcement.status, json['status']);
    });

    test(
        'fromJson should correctly parse json with null values to announcement object',
        () {
      final announcement = Announcement2.fromJson(nullJson);
      expect(announcement, isInstanceOf<Announcement2>());
    });
  });
}
