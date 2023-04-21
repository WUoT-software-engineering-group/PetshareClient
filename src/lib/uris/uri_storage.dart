enum UriAnnouncement {
  getId,
  put,
  get,
  post,
  getShelterAnnouncements,
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

  UriStorage({
    required String announcement,
    required String shelter,
    required String adopter,
  }) {
    _announcementAPI = announcement;
    _shelterAPI = shelter;
    _adopterAPI = adopter;
  }

  /// Factory: Asia, Dawid, Kuba, Paweł
  factory UriStorage.initADKP() {
    const String baseAPI = 'https://pet-share-web-api-dev.azurewebsites.net';
    return UriStorage(
      announcement: baseAPI,
      shelter: baseAPI,
      adopter: baseAPI,
    );
  }

  /// Factory: Daniel, Lusia, Piotrek, Szymon
  factory UriStorage.initDLPS() {
    return UriStorage(
      announcement: 'https://petshare-announcementsapi.azurewebsites.net/',
      shelter: 'https://petshare-shelterapi.azurewebsites.net/',
      adopter: 'https://petshare-adopterapi.azurewebsites.net/',
    );
  }

  // --------------------------
  // Paths methods
  // --------------------------

  String announcementUriString(UriAnnouncement type, {String id = ''}) {
    switch (type) {
      case UriAnnouncement.getId:
        return "$_announcementAPI/announcements";
      case UriAnnouncement.put:
        return "$_announcementAPI/announcements";
      case UriAnnouncement.get:
        return "$_announcementAPI/announcements/$id";
      case UriAnnouncement.post:
        return "$_announcementAPI/announcements/$id";
      case UriAnnouncement.getShelterAnnouncements:
        return "$_announcementAPI/shelter/announcements";
    }
  }

  Uri announcementUri(UriAnnouncement type, {String id = ''}) =>
      Uri.parse(announcementUriString(type, id: id));

  String petUriString(UriPet type, {String id = ''}) {
    switch (type) {
      case UriPet.getId:
        return "$_announcementAPI/pet/$id";
      case UriPet.putId:
        return "$_announcementAPI/pet/$id";
      case UriPet.post:
        return "$_announcementAPI/pet";
      case UriPet.postIdPhoto:
        return "$_announcementAPI/pet/$id/photo";
      case UriPet.getShelterPets:
        return "$_announcementAPI/pet/shelter/pets";
    }
  }

  Uri petUri(UriPet type, {String id = ''}) =>
      Uri.parse(petUriString(type, id: id));

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

  Uri shelterUri(UriShelter type, {String id = ''}) =>
      Uri.parse(shelterUriString(type, id: id));

  String adopterUriString(UriAdopter type, {String id = ''}) {
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
      Uri.parse(adopterUriString(type, id: id));

  // String applicationsUriString(UriApplications type, {String id = ''}) {}
}
