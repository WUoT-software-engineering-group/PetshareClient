import 'dart:convert';

import 'package:pet_share/models/pet.dart';

class Announcement {
  final String id;
  final String title;
  final String description;
  final DateTime creationDate;
  final DateTime? closingDate;
  final DateTime lastUpdateDate;
  final int status;
  final Pet pet;
  final Author author;

  // -------------------------
  // Constructors & Factories
  // -------------------------

  Announcement({
    required this.id,
    required this.title,
    required this.description,
    required this.creationDate,
    required this.closingDate,
    required this.lastUpdateDate,
    required this.status,
    required this.pet,
    required this.author,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      creationDate: DateTime.parse(json['creationDate']),
      closingDate: json['closingDate'] == null
          ? null
          : DateTime.parse(json['closingDate']),
      lastUpdateDate: DateTime.parse(json['lastUpdateDate']),
      status: json['status'],
      pet: Pet.fromJson(json['pet']),
      author: Author.fromJson(json['author']),
    );
  }
}

class Author {
  final String id;
  final String userName;
  final String phoneNumer;
  final String email;
  final String? fullShelterName;
  final bool isAuthorized;
  final Address? adress;

  // -------------------------
  // Constructors & Factories
  // -------------------------

  Author(
      {required this.id,
      required this.userName,
      required this.phoneNumer,
      required this.email,
      required this.fullShelterName,
      required this.isAuthorized,
      required this.adress});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      userName: json['userName'],
      phoneNumer: _testNumber(json['phoneNumer']),
      email: json['email'],
      fullShelterName: json['fluuShelterName'],
      isAuthorized: json['isAuthorized'],
      adress: json['adress'] == null ? null : Address.fromJson(json['adress']),
    );
  }

  // -------------------------
  // Validation methods
  // -------------------------

  static String _testNumber(String? phone) {
    if (phone == null) {
      return '0000000000';
    } else {
      return phone;
    }
  }
}

class Address {
  final String street;
  final String city;
  final String provice;
  final String postalCode;
  final String country;

  // -------------------------
  // Constructors & Factories
  // -------------------------

  Address(
      {required this.street,
      required this.city,
      required this.provice,
      required this.postalCode,
      required this.country});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        street: json['street'],
        city: json['city'],
        provice: json['provice'],
        postalCode: json['postalCode'],
        country: json['country']);
  }

  // -------------------------
  // Conversion methods
  // -------------------------

  Map<String, dynamic> convertToSD() => {
        'street': street,
        'city': city,
        'province': provice,
        'postalCode': postalCode,
        'country': country,
      };
}

class AnnouncementPost {
  final String title;
  final String description;
  final String? petId;
  final Pet? pet;

  // -------------------------
  // Constructors & Factories
  // -------------------------

  AnnouncementPost({
    required this.title,
    required this.description,
    this.petId,
    this.pet,
  });

  // -------------------------
  // Conversion methods
  // -------------------------

  String toJson() => jsonEncode(
        <String, dynamic>{
          'title': title,
          'description': description,
          'author': 'XD',
          'pet': pet != null ? pet!.covertToMapSD() : '',
        },
      );
}

class Announcement2 {
  String id;
  String title;
  String description;
  DateTime? creationDate;
  DateTime? closingDate;
  DateTime? lastUpdateDate;
  int status;
  Pet2 pet;

  // -------------------------
  // Constructors & Factories
  // -------------------------

  Announcement2({
    required this.id,
    required this.title,
    required this.description,
    required this.creationDate,
    required this.closingDate,
    required this.lastUpdateDate,
    required this.status,
    required this.pet,
  });

  factory Announcement2.fromJson(Map<String, dynamic> json) {
    return Announcement2(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      creationDate: testDateTime(json['creationDate']),
      closingDate: testDateTime(json['closingDate']),
      lastUpdateDate: testDateTime(json['lastUpdateDate']),
      status: json['status'] ?? -1,
      pet: Pet2.fromJson(json['pet']),
    );
  }

  static DateTime? testDateTime(dynamic dateTime) =>
      dateTime == null ? null : DateTime.parse(dateTime);
}
