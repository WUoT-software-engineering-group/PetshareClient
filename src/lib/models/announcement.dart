import 'dart:convert';

import 'package:pet_share/models/pet.dart';

enum AnnouncementStatus {
  open,
  closed,
  deleted,
  unknown,
}

class Announcement2 {
  String id;
  bool isLiked;
  String title;
  String description;
  DateTime? creationDate;
  DateTime? closingDate;
  DateTime? lastUpdateDate;
  AnnouncementStatus status;
  Pet2 pet;

  // -------------------------
  // Constructors & Factories
  // -------------------------

  Announcement2({
    required this.id,
    required this.isLiked,
    required this.title,
    required this.description,
    required this.creationDate,
    required this.closingDate,
    required this.lastUpdateDate,
    required this.status,
    required this.pet,
  });

  factory Announcement2.fromJson(Map<String, dynamic> json) {
    return Announcement2(
      id: json['id'] ?? "",
      isLiked: json['isLiked'] ?? false,
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      creationDate: testDateTime(json['creationDate']),
      closingDate: testDateTime(json['closingDate']),
      lastUpdateDate: testDateTime(json['lastUpdateDate']),
      status: parseStatus(json['status']),
      pet: Pet2.fromJson(json['pet']),
    );
  }

  static DateTime? testDateTime(dynamic dateTime) =>
      dateTime == null ? null : DateTime.parse(dateTime);

  static AnnouncementStatus parseStatus(String? status) {
    if (status == null) return AnnouncementStatus.unknown;

    status = status.toLowerCase();
    switch (status) {
      case 'open':
        return AnnouncementStatus.open;
      case 'closed':
        return AnnouncementStatus.closed;
      case 'deleted':
        return AnnouncementStatus.deleted;
      default:
        return AnnouncementStatus.unknown;
    }
  }
}

class CreatingAnnouncement2 {
  String title;
  String description;
  String petId;

  CreatingAnnouncement2({
    required this.title,
    required this.description,
    required this.petId,
  });

  String toJson() {
    return jsonEncode(
      <String, dynamic>{
        'title': title,
        'description': description,
        'petId': petId,
      },
    );
  }
}
