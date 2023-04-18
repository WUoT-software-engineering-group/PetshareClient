import 'package:pet_share/models/announcement.dart';

class Adopter {
  String userName;
  String phoneNumber;
  String email;
  Address address;

  Adopter({
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.address,
  });

  factory Adopter.fromJson(Map<String, dynamic> json) {
    return Adopter(
      userName: json['username'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      address: Address.fromJson(json['address']),
    );
  }
}
