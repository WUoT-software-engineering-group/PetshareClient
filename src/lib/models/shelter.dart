import 'dart:convert';

import 'announcement.dart';

class Shelter {
  String userName;
  String phoneNumber;
  String email;
  String fullShelterName;
  Address address;

  // -------------------------
  // Constructors & Factories
  // -------------------------

  Shelter({
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.fullShelterName,
    required this.address,
  });

  factory Shelter.fromJson(Map<String, dynamic> json) {
    return Shelter(
      userName: json['username'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      fullShelterName: json['fullShelterName'],
      address: Address.fromJson(json['address']),
    );
  }

  // -------------------------
  // Conversion methods
  // -------------------------

  String toJson() {
    return jsonEncode(
      {
        'userName': userName,
        'phoneNumber': phoneNumber,
        'email': email,
        'fullShelterName': fullShelterName,
        'address': address.convertToSD(),
      },
    );
  }
}
