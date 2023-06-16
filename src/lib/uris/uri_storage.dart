import 'package:flutter_dotenv/flutter_dotenv.dart';

enum UriAnnouncement {
  getId,
  put,
  get,
  post,
  getShelterAnnouncements,
  putIdLike
}

enum UriPet {
  getId,
  getShelterPets,
  putId,
  post,
  postIdPhoto,
}

enum UriShelter {
  get,
  post,
  getId,
  putId,
}

enum UriAdopter {
  get,
  post,
  getId,
  putId,
  putIdVerify,
  getIdIsVerified,
}

enum UriApplications {
  get,
  post,
  getId,
  putIdAccept,
  putIdReject,
  putIdWithdraw,
}

class UriStorage {
  final String scheme = 'https';

  late String _announcementAPI;
  late String _shelterAPI;
  late String _adopterAPI;

  // --------------------------
  // Factory and constructors
  // --------------------------

  UriStorage() {
    _announcementAPI = dotenv.env['ANNOUNCEMENTS_API_URL']!;
    _shelterAPI = dotenv.env['SHELTER_API_URL']!;
    _adopterAPI = dotenv.env['ADOPTER_API_URL']!;
  }

  // --------------------------
  // Paths methods
  // --------------------------

  String announcementUriString(
    UriAnnouncement type, {
    String id = '',
    Map<String, String> queryParm = const {},
  }) {
    String rep = '';
    switch (type) {
      case UriAnnouncement.get:
        rep = "$_announcementAPI/announcements";
        break;
      case UriAnnouncement.put:
        rep = "$_announcementAPI/announcements";
        break;
      case UriAnnouncement.getId:
        rep = "$_announcementAPI/announcements/$id";
        break;
      case UriAnnouncement.post:
        rep = "$_announcementAPI/announcements/$id";
        break;
      case UriAnnouncement.getShelterAnnouncements:
        rep = "$_announcementAPI/shelter/announcements";
        break;
      case UriAnnouncement.putIdLike:
        rep = "$_announcementAPI/announcements/$id/like";
        break;
    }

    List<String> uri = [rep, '?'];
    queryParm.forEach((key, value) {
      uri.add(key);
      uri.add('=');
      uri.add(value);
      uri.add('&');
    });
    uri.removeLast();
    return uri.join();
  }

  Uri announcementUri(
    UriAnnouncement type, {
    String id = '',
    Map<String, String> queryParm = const {},
  }) =>
      Uri.parse(announcementUriString(
        type,
        id: id,
        queryParm: queryParm,
      ));

  String petUriString(
    UriPet type, {
    String id = '',
    Map<String, String> queryParm = const {},
  }) {
    String rep = '';
    switch (type) {
      case UriPet.getId:
        rep = "$_announcementAPI/pet/$id";
        break;
      case UriPet.putId:
        rep = "$_announcementAPI/pet/$id";
        break;
      case UriPet.post:
        rep = "$_announcementAPI/pet";
        break;
      case UriPet.postIdPhoto:
        rep = "$_announcementAPI/pet/$id/photo";
        break;
      case UriPet.getShelterPets:
        rep = "$_announcementAPI/shelter/pets";
        break;
    }

    List<String> uri = [rep, '?'];
    queryParm.forEach((key, value) {
      uri.add(key);
      uri.add('=');
      uri.add(value);
      uri.add('&');
    });
    uri.removeLast();

    return uri.join();
  }

  Uri petUri(
    UriPet type, {
    String id = '',
    Map<String, String> queryParm = const {},
  }) =>
      Uri.parse(petUriString(
        type,
        id: id,
        queryParm: queryParm,
      ));

  String shelterUriString(UriShelter type, {String id = ''}) {
    switch (type) {
      case UriShelter.get:
        return "$_shelterAPI/shelter";
      case UriShelter.post:
        return "$_shelterAPI/shelter";
      case UriShelter.getId:
        return "$_shelterAPI/shelter/$id";
      case UriShelter.putId:
        return "$_shelterAPI/shelter/$id";
    }
  }

  Uri shelterUri(
    UriShelter type, {
    String id = '',
  }) =>
      Uri.parse(shelterUriString(
        type,
        id: id,
      ));

  String adopterUriString(
    UriAdopter type, {
    String id = '',
  }) {
    switch (type) {
      case UriAdopter.get:
        return "$_adopterAPI/adopter";
      case UriAdopter.post:
        return "$_adopterAPI/adopter";
      case UriAdopter.getId:
        return "$_adopterAPI/adopter/$id";
      case UriAdopter.putId:
        return "$_adopterAPI/adopter/$id";
      case UriAdopter.putIdVerify:
        return "$_adopterAPI/adopter/$id/verify";
      case UriAdopter.getIdIsVerified:
        return "$_adopterAPI/adopter/$id/isVerified";
    }
  }

  Uri adopterUri(UriAdopter type, {String id = ''}) =>
      Uri.parse(adopterUriString(
        type,
        id: id,
      ));

  String applicationsUriString(
    UriApplications type, {
    String id = '',
    Map<String, String> queryParm = const {},
  }) {
    String rep = '';
    switch (type) {
      case UriApplications.get:
        rep = "$_adopterAPI/applications";
        break;
      case UriApplications.post:
        rep = "$_adopterAPI/applications";
        break;
      case UriApplications.getId:
        rep = "$_adopterAPI/applications/$id";
        break;
      case UriApplications.putIdAccept:
        rep = "$_adopterAPI/applications/$id/accept";
        break;
      case UriApplications.putIdReject:
        rep = "$_adopterAPI/applications/$id/reject";
        break;
      case UriApplications.putIdWithdraw:
        rep = "$_adopterAPI/applications/$id/withdraw";
        break;
    }

    List<String> uri = [rep, '?'];
    queryParm.forEach((key, value) {
      uri.add(key);
      uri.add('=');
      uri.add(value);
      uri.add('&');
    });
    uri.removeLast();

    return uri.join();
  }

  Uri applicationsUri(
    UriApplications type, {
    String id = '',
    Map<String, String> queryParm = const {},
  }) =>
      Uri.parse(applicationsUriString(
        type,
        id: id,
        queryParm: queryParm,
      ));
}
