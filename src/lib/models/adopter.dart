import 'dart:convert';

import 'package:pet_share/models/address.dart';
import 'package:pet_share/models/announcement.dart';

class Adopter {
  String userName;
  String phoneNumber;
  String email;
  Address address;

  // -------------------------
  // Constructors & Factories
  // -------------------------

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

  // -------------------------
  // Conversion methods
  // -------------------------

  String toJson() {
    return jsonEncode(
      {
        'userName': userName,
        'phoneNumber': phoneNumber,
        'email': email,
        'address': address.convertToSD(),
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
      status: json["status"] ?? 1,
    );
  }

  // -------------------------
  // Conversion methods
  // -------------------------

  // Map<String, dynamic> buildRespons() {
  //   Map<String, dynamic> respons = address.buildRespons();

  //   return {
  //     'userName': userName,
  //     'phoneNumber': phoneNumber,
  //     'email': email,
  //     'address': respons,
  //   };
  // }
}
