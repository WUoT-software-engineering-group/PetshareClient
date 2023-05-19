import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pet_share/models/shelter.dart';

enum SexOfPet {
  unknown,
  male,
  female,
  doesNotApply,
}

class Pet2 {
  String id;
  Shelter2 shelter;
  String name;
  String species;
  String breed;
  DateTime? birthday;
  String description;
  int status;
  SexOfPet sex;
  String photoUrl;

  // -------------------------
  // Constructors & Factories
  // -------------------------

  Pet2({
    required this.id,
    required this.shelter,
    required this.name,
    required this.species,
    required this.breed,
    required this.birthday,
    required this.description,
    required this.photoUrl,
    required this.status,
    required this.sex,
  });

  factory Pet2.fromJson(Map<String, dynamic> json) {
    return Pet2(
      id: json['id'] ?? "",
      shelter: Shelter2.fromJson(json['shelter']),
      name: json['name'] ?? "",
      species: json['species'] ?? "",
      breed: json['breed'] ?? "",
      birthday: testDateTime(json['birthday']),
      description: json['description'] ?? "",
      photoUrl: json['photoUrl'] ?? "",
      status: json['status'] ?? "",
      sex: intToSex(json['sex']),
    );
  }

  static DateTime? testDateTime(dynamic dateTime) =>
      dateTime == null ? null : DateTime.parse(dateTime);

  static SexOfPet intToSex(int? sex) {
    if (sex == null) return SexOfPet.unknown;

    switch (sex) {
      case 0:
        return SexOfPet.unknown;
      case 1:
        return SexOfPet.male;
      case 2:
        return SexOfPet.female;
    }

    return SexOfPet.doesNotApply;
  }
}

class CreatingPet2 {
  String name;
  String species;
  String breed;
  DateTime? birthday;
  String description;
  SexOfPet sex;
  XFile image;

  // -------------------------
  // Constructors & Factories
  // -------------------------

  CreatingPet2({
    required this.name,
    required this.species,
    required this.breed,
    required this.birthday,
    required this.description,
    required this.sex,
    required this.image,
  });

  // -------------------------
  // Convert to json
  // -------------------------

  String toJson() {
    DateTime time = birthday ?? DateTime.now();

    String date =
        '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(time).toString()}Z';

    return jsonEncode(
      <String, dynamic>{
        'name': name,
        'species': species,
        'breed': breed,
        'birthday': date,
        'description': description,
        'sex': sexToInt(sex),
        'photoUrl': image.name,
      },
    );
  }

  static int sexToInt(SexOfPet sex) {
    switch (sex) {
      case SexOfPet.unknown:
        return 0;
      case SexOfPet.male:
        return 1;
      case SexOfPet.female:
        return 2;
      case SexOfPet.doesNotApply:
        return 3;
    }
  }
}
