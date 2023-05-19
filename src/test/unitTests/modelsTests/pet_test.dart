// import 'package:flutter_test/flutter_test.dart';
// import 'package:intl/intl.dart';
// import 'package:pet_share/models/pet.dart';

// void main() {
//   group('Pet', () {
//     final petJson = {
//       'id': '1',
//       'shelterID': 'shelter_1',
//       'name': 'Buddy',
//       'species': 'Dog',
//       'breed': 'Labrador',
//       'birthday': '2020-01-01T00:00:00.000',
//       'description': 'A friendly and playful dog.',
//       'photo': 'https://costamcostam',
//     };

//     final pet = Pet(
//       id: '1',
//       shelterID: 'shelter_1',
//       name: 'Buddy',
//       species: 'Dog',
//       breed: 'Labrador',
//       birthday: DateTime(2020, 1, 1),
//       description: 'A friendly and playful dog.',
//       photo: 'https://costamcostam',
//     );

//     test('fromJson should correctly parse a JSON object', () {
//       final result = Pet.fromJson(petJson);

//       expect(result.id, pet.id);
//       expect(result.shelterID, pet.shelterID);
//       expect(result.name, pet.name);
//       expect(result.species, pet.species);
//       expect(result.breed, pet.breed);
//       expect(result.birthday, pet.birthday);
//       expect(result.description, pet.description);
//       expect(result.photo, pet.photo);
//     });

//     test('covertToMapSD should correctly convert to a Map object', () {
//       final result = pet.covertToMapSD();

//       expect(result['name'], pet.name);
//       expect(result['species'], pet.species);
//       expect(result['breed'], pet.breed);
//       expect(result['description'], pet.description);
//       expect(result['photo'], pet.photo.toString());

//       final expectedDate =
//           '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(pet.birthday).toString()}Z';
//       expect(result['birthday'], expectedDate);
//     });

//     test('toJson should correctly convert to a JSON string', () {
//       final result = pet.toJson();

//       final expected =
//           '{"name":"${pet.name}","species":"${pet.species}","breed":"${pet.breed}","birthday":"${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(pet.birthday).toString()}Z","description":"${pet.description}","photo":"${pet.photo.toString()}"}';
//       expect(result, expected);
//     });
//   });
// }
