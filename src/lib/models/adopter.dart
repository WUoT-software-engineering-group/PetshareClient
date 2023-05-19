import 'dart:convert';
import 'package:pet_share/models/address.dart';

class CreatingAdopter {
  String userName;
  String phoneNumber;
  String email;
  Address2 address;

  // -------------------------
  // Constructors & Factories
  // -------------------------

  CreatingAdopter({
    required this.userName,
    required this.phoneNumber,
    required this.email,
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
        'address': address.makeReponse(),
      },
    );
  }
}

class Adopter2 {
  String id;
  String userName;
  String phoneNumber;
  String email;
  Address2 address;
  int status;

  // -------------------------
  // Constructors & Factories
  // -------------------------

  Adopter2({
    required this.id,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.status,
  });

  factory Adopter2.fromJson(Map<String, dynamic> json) {
    return Adopter2(
      id: json["id"] ?? "",
      userName: json["userName"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      email: json["email"] ?? "",
      address: Address2.fromJson(json['address']),
      status: json["status"] ?? "",
    );
  }
}
