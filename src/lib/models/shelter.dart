import 'dart:convert';
import 'package:pet_share/models/address.dart';

class CreatingShelter {
  String userName;
  String phoneNumber;
  String email;
  String fullShelterName;
  Address2 address;

  // -------------------------
  // Constructors & Factories
  // -------------------------

  CreatingShelter({
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.fullShelterName,
    required this.address,
  });

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
        'address': address.makeReponse(),
      },
    );
  }
}

class Shelter2 {
  String id;
  String userName;
  String phoneNumber;
  String email;
  String fullShelterName;
  bool isAuthorized;
  Address2 address;

  Shelter2({
    required this.id,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.fullShelterName,
    required this.isAuthorized,
    required this.address,
  });

  factory Shelter2.fromJson(Map<String, dynamic> json) {
    return Shelter2(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      fullShelterName: json['fullShelterName'] ?? '',
      isAuthorized: json['isAuthorized'] ?? '',
      address: Address2.fromJson(json['address']),
    );
  }
}
