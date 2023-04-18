import 'announcement.dart';

class Shelter {
  String username;
  String phoneNumber;
  String email;
  String fullShelterName;
  Address address;

  Shelter({
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.fullShelterName,
    required this.address,
  });

  factory Shelter.fromJson(Map<String, dynamic> json) {
    return Shelter(
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      fullShelterName: json['fullShelterName'],
      address: Address.fromJson(json['address']),
    );
  }
}
