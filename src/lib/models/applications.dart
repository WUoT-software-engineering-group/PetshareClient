import 'package:pet_share/models/adopter.dart';
import 'package:pet_share/models/announcement.dart';

enum ApplicationStatus {
  created,
  accepted,
  rejected,
  withdrawn,
  deleted,
  unknown,
}

class Appplications2 {
  String id;
  DateTime? creationDate;
  DateTime? lastUpdateDate;
  String announcementId;
  Announcement2 announcement;
  Adopter2 adopter;
  ApplicationStatus applicationStatus;

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
      applicationStatus: parseStatus(json['applicationStatus']),
    );
  }

  static DateTime? testDateTime(dynamic dateTime) =>
      dateTime == null ? null : DateTime.parse(dateTime);

  static ApplicationStatus parseStatus(String? status) {
    if (status == null) return ApplicationStatus.unknown;

    switch (status) {
      case 'Created':
        return ApplicationStatus.created;
      case 'Accepted':
        return ApplicationStatus.accepted;
      case 'Rejected':
        return ApplicationStatus.rejected;
      case 'Withdrawn':
        return ApplicationStatus.withdrawn;
      case 'Deleted':
        return ApplicationStatus.deleted;
      default:
        return ApplicationStatus.unknown;
    }
  }
}
