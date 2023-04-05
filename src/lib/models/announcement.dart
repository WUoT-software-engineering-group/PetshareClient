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

  Announcement(
      {required this.id,
      required this.title,
      required this.description,
      required this.creationDate,
      required this.closingDate,
      required this.lastUpdateDate,
      required this.status,
      required this.pet,
      required this.author});

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
        author: Author.fromJson(json['author']));
  }
}

class Author {
  final String id;
  final String userName;
  final String? phoneNumer;
  final String email;
  final String? fluuShelterName;
  final bool isAuthorized;
  final Address? adress;

  Author(
      {required this.id,
      required this.userName,
      required this.phoneNumer,
      required this.email,
      required this.fluuShelterName,
      required this.isAuthorized,
      required this.adress});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
        id: json['id'],
        userName: json['userName'],
        phoneNumer: json['phoneNumer'],
        email: json['email'],
        fluuShelterName: json['fluuShelterName'],
        isAuthorized: json['isAuthorized'],
        adress:
            json['adress'] == null ? null : Address.fromJson(json['adress']));
  }
}

class Address {
  final String street;
  final String city;
  final String provice;
  final String postalCode;
  final String country;

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
}

class AnnouncementPost {
  final String title;
  final String description;
  final String? petId;
  final Pet? pet;

  AnnouncementPost(
      {required this.title, required this.description, this.petId, this.pet});
}
