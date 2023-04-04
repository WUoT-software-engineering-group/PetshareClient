import 'dart:developer';

class Pet {
  final String id;
  final String shelterID;
  final String name;
  final String species;
  final String breed;
  final DateTime birthday;
  final String description;
  final List<int> photo;

  Pet(
      {required this.id,
      required this.shelterID,
      required this.name,
      required this.species,
      required this.breed,
      required this.birthday,
      required this.description,
      required this.photo});

  factory Pet.post(
      {required String name,
      required String species,
      required String breed,
      required DateTime birthday,
      required String description,
      required List<int> photo}) {
    return Pet(
        id: '',
        shelterID: '',
        name: name,
        species: species,
        breed: breed,
        birthday: birthday,
        description: description,
        photo: photo);
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
        photo: _parsePhoto(json['photo']));
  }

  static List<int> _parsePhoto(dynamic photo) {
    if (photo is List<dynamic>) {
      return photo.map((e) => e as int).toList();
    } else {
      log('pet: format of photo is different');
      return <int>[];
    }
  }
}
