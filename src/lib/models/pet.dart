import 'dart:convert';
import 'dart:developer';

import 'package:intl/intl.dart';

class Pet {
  final String id;
  final String shelterID;
  final String name;
  final String species;
  final String breed;
  final DateTime birthday;
  final String description;
  final String photo;

  // -------------------------
  // Constructors & Factories
  // -------------------------

  Pet({
    required this.id,
    required this.shelterID,
    required this.name,
    required this.species,
    required this.breed,
    required this.birthday,
    required this.description,
    required this.photo,
  });

  factory Pet.post({
    required String name,
    required String species,
    required String breed,
    required DateTime birthday,
    required String description,
    required String photo,
  }) {
    return Pet(
      id: '',
      shelterID: '',
      name: name,
      species: species,
      breed: breed,
      birthday: birthday,
      description: description,
      photo: photo,
    );
  }

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      shelterID: json['shelterID'],
      name: json['name'],
      species: json['species'],
      breed: json['breed'],
      birthday: DateTime.parse(json['birthday']),
      description: json['description'],
      photo: json['photoUri'],
    );
  }

  // -------------------------
  // Conversion methods
  // -------------------------

  String toJson() => jsonEncode(covertToMapSD());

  Map<String, dynamic> covertToMapSD() {
    String date =
        '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(birthday).toString()}Z';

    return <String, dynamic>{
      'name': name,
      'species': species,
      'breed': breed,
      'birthday': date,
      'description': description,
      'photo': photo.toString(),
    };
  }
}
