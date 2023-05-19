import 'package:pet_share/models/adopter.dart';
import 'package:pet_share/models/announcement.dart';

class Appplications2 {
  String id;
  DateTime? creationDate;
  DateTime? lastUpdateDate;
  String announcementId;
  Announcement2 announcement;
  Adopter2 adopter;
  int applicationStatus;

  Appplications2({
    required this.id,
    required this.creationDate,
    required this.lastUpdateDate,
    required this.announcementId,
    required this.announcement,
    required this.adopter,
    required this.applicationStatus,
  });

  factory Appplications2.fromJson(Map<String, dynamic> json) {
    return Appplications2(
      id: json['id'] ?? '',
      creationDate: testDateTime(json['creationDate']),
      lastUpdateDate: testDateTime(json['lastUpdateDate']),
      announcementId: json['announcementId'] ?? '',
      announcement: Announcement2.fromJson(json['announcement']),
      adopter: Adopter2.fromJson(json['adopter']),
      applicationStatus: json['applicationStatus'] ?? 0,
    );
  }

  static DateTime? testDateTime(dynamic dateTime) =>
      dateTime == null ? null : DateTime.parse(dateTime);
}
