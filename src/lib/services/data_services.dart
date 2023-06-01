import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pet_share/models/address.dart';
import 'package:pet_share/models/adopter.dart';
import 'package:pet_share/models/announcement.dart';
import 'package:pet_share/models/applications.dart';
import 'package:pet_share/models/pet.dart';
import 'package:pet_share/models/shelter.dart';
import 'package:pet_share/uris/uri_storage.dart';
import 'package:dio/dio.dart';

class DataServices2 {
  late UriStorage _uriStorage;

  // ----------------------------------
  // Contstructors
  // ----------------------------------

  DataServices2({bool dlps = false}) {
    _uriStorage = UriStorage.initADKP();
    if (dlps) {
      _uriStorage = UriStorage.initDLPS();
    }
  }

  // -----------------------------------
  // DataServices methods
  // -----------------------------------

  Map<String, String> buildHeader(String accessToken) {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken',
    };
  }

  // -----------------------------------
  // Adopter methods
  // -----------------------------------

  Future<String> postAdopter(CreatingAdopter post, String accessToken) async {
    http.Response res = await http.post(
      _uriStorage.adopterUri(UriAdopter.post),
      headers: buildHeader(accessToken),
      body: post.toJson(),
    );

    String idToken = res.headers['location'] ?? '';
    if (res.statusCode != 201) {
      idToken = '';
      log('DataServices: postAdopter: bad post: the error is ${res.statusCode.toString()}');
      throw DataServicesUnloggedException('Registering a new adopter failed!');
    }

    return idToken;
  }

  Future<List<Adopter2>> getAdopters(
    String accessToken,
  ) async {
    http.Response res = await http.get(
      _uriStorage.adopterUri(UriAdopter.get),
      headers: buildHeader(accessToken),
    );

    if (res.statusCode == 200) {
      List<dynamic> list = json.decode(res.body);
      return list.map((e) => Adopter2.fromJson(e)).toList();
    } else {
      log('DataServices: getAdopters: bad get: ${res.statusCode} :: ${res.body}');
      throw DataServicesLoggedException('Getting the list of adopters failed!');
    }
  }

  // -----------------------------------
  // Shelter methods
  // -----------------------------------

  Future<String> postShelter(CreatingShelter post, String accessToken) async {
    http.Response res = await http.post(
      _uriStorage.shelterUri(UriShelter.post),
      headers: buildHeader(accessToken),
      body: post.toJson(),
    );

    String idToken = res.headers['location'] ?? '';
    if (res.statusCode != 201) {
      idToken = '';
      log('DataServices: postShelter: bad post: the error is ${res.statusCode.toString()}');
      throw DataServicesUnloggedException('Registering a new shelter failed!');
    }

    return idToken;
  }

  Future<List<Pet2>> getShelterPets(
    String accessToken,
  ) async {
    http.Response res = await http.get(
      _uriStorage.petUri(UriPet.getShelterPets),
      headers: buildHeader(accessToken),
    );

    if (res.statusCode == 200) {
      List<dynamic> list = json.decode(res.body);
      return list.map((e) => Pet2.fromJson(e)).toList();
    } else {
      log('DataServices: getShelterPets: bad get: ${res.statusCode} :: ${res.body}');
      throw DataServicesLoggedException(
          'Getting the list of pets for the shelter failed!');
    }
  }

  Future<List<Announcement2>> getShelterAnnouncements(
    String accessToken, {
    Map<String, String> queryParm = const {},
  }) async {
    http.Response res = await http.get(
      _uriStorage.announcementUri(
        UriAnnouncement.getShelterAnnouncements,
        queryParm: queryParm,
      ),
      headers: buildHeader(accessToken),
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> respons = json.decode(res.body);
      List<dynamic> list = respons['announcements'];
      return list.map((e) => Announcement2.fromJson(e)).toList();
    } else {
      log('DataServices: getShelterAnnouncements: bad get: ${res.statusCode} :: ${res.body}');
      throw DataServicesLoggedException(
          'Getting the list of announcements for the shelter failed!');
    }
  }

  // -----------------------------------
  // Announcement methods
  // -----------------------------------

  Future<List<Announcement2>> getAnnouncements(
    String accessToken, {
    Map<String, String> queryParm = const {},
  }) async {
    http.Response res = await http.get(
      _uriStorage.announcementUri(
        UriAnnouncement.get,
        queryParm: queryParm,
      ),
      headers: buildHeader(accessToken),
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> respons = json.decode(res.body);
      List<dynamic> list = respons['announcements'];
      return list.map((e) => Announcement2.fromJson(e)).toList();
    } else {
      log('DataServices: getAnnouncements: bad get: ${res.statusCode} :: ${res.body}');
      throw DataServicesLoggedException(
          'Getting the list of all announcements failed!');
    }
  }

  Future<void> postAnnouncement(
    String accessToken,
    CreatingAnnouncement2 announcement,
  ) async {
    http.Response res = await http.post(
      _uriStorage.announcementUri(UriAnnouncement.post),
      headers: buildHeader(accessToken),
      body: announcement.toJson(),
    );

    if (res.statusCode != 201) {
      log('DataServices: postAnnouncement: bad post: ${res.statusCode} :: ${res.body}');
      throw DataServicesLoggedException('Posting a new announcement failed!');
    }
  }

  // -----------------------------------
  // Applications methods
  // -----------------------------------

  Future<List<Appplications2>> getApplications(
    String accessToken,
  ) async {
    http.Response res = await http.get(
      _uriStorage.applicationsUri(UriApplications.get),
      headers: buildHeader(accessToken),
    );

    if (res.statusCode == 200) {
      List<dynamic> list = json.decode(res.body);
      return list.map((e) => Appplications2.fromJson(e)).toList();
    } else {
      log('DataServices: getApplications: bad get: ${res.statusCode} :: ${res.body}');
      throw DataServicesLoggedException(
          'Getting a list of all aplications failed!');
    }
  }

  Future<void> postApplication(
    String accessToken,
    String announcementId,
    String adopterId,
  ) async {
    http.Response res = await http.post(
      _uriStorage.applicationsUri(UriApplications.post),
      headers: buildHeader(accessToken),
      body: jsonEncode({
        'announcementId': announcementId,
      }),
    );

    if (res.statusCode != 201) {
      log('DataServices: postApplication: bad post application: ${res.statusCode} :: ${res.body}');
      throw DataServicesLoggedException('Posting a new application failed!');
    }
  }

  Future<Appplications2> getApplicationWithId(
    String accessToken,
    String announcementId,
  ) async {
    return Appplications2(
      id: 'id',
      creationDate: DateTime.now(),
      lastUpdateDate: DateTime.now(),
      announcementId: 'announcementId',
      announcement: Announcement2(
        id: 'id',
        title: 'title',
        description: 'description',
        creationDate: null,
        closingDate: null,
        lastUpdateDate: null,
        status: 0,
        pet: Pet2(
            id: 'id',
            shelter: Shelter2(
              id: 'id',
              userName: 'userName',
              phoneNumber: 'phoneNumber',
              email: 'email',
              fullShelterName: 'fullShelterName',
              isAuthorized: false,
              address: Address2(
                  street: 'street',
                  city: '',
                  provice: 'provice',
                  postalCode: 'postalCode',
                  country: 'country'),
            ),
            name: 'name',
            species: 'species',
            breed: 'breed',
            birthday: null,
            description: 'description',
            photoUrl: 'photoUrl',
            status: 0,
            sex: SexOfPet.male),
      ),
      adopter: Adopter2(
          id: '',
          userName: 'userName',
          phoneNumber: 'phoneNumber',
          email: 'email',
          address: Address2(
              street: 'street',
              city: 'city',
              provice: 'provice',
              postalCode: 'postalCode',
              country: 'country'),
          status: 0),
      applicationStatus: 0,
    );
  }

  Future<void> putAcceptApplication(
    String accessToken,
    String applicationId,
  ) async {
    http.Response res = await http.put(
      _uriStorage.applicationsUri(
        UriApplications.putIdAccept,
        id: applicationId,
      ),
      headers: buildHeader(accessToken),
    );

    if (res.statusCode != 200) {
      log('DataServices: putAcceptApplication: bad put accept-application: ${res.statusCode} :: ${res.body}');
      throw DataServicesLoggedException(
          'Putting an accept application failed!');
    }
  }

  Future<void> putRejectApplication(
    String accessToken,
    String applicationId,
  ) async {
    http.Response res = await http.put(
      _uriStorage.applicationsUri(
        UriApplications.putIdReject,
        id: applicationId,
      ),
      headers: buildHeader(accessToken),
    );

    if (res.statusCode != 200) {
      log('DataServices: putRejectApplication: bad reject-application: ${res.statusCode} :: ${res.body}');
      throw DataServicesLoggedException('Putting a reject application failed!');
    }
  }

  // -----------------------------------
  // Pet methods
  // -----------------------------------

  Future<void> postPet(
    String accessToken,
    CreatingPet2 pet,
  ) async {
    http.Response res = await http.post(
      _uriStorage.petUri(UriPet.post),
      headers: buildHeader(accessToken),
      body: pet.toJson(),
    );

    if (res.statusCode != 201) {
      log('DataServices: postPet: bad post pet:  ${res.statusCode} :: ${res.body}');
      throw DataServicesLoggedException('Posting a new pet failed!');
    }

    var response = await _uploadPetImage(
      res.headers['location']!,
      accessToken,
      pet.image,
    );

    if (response.statusCode != 200) {
      log('DataServices: postPet: bad post pet image:  ${response.statusCode}');
      throw DataServicesLoggedException('Posting an image failed!');
    }
  }

  Future<Response<dynamic>> _uploadPetImage(
    String id,
    String accessToken,
    XFile file,
  ) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap(
      {
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      },
    );
    Dio dio = Dio();

    var header = buildHeader(accessToken);
    header.forEach(
      (key, value) {
        dio.options.headers[key] = value;
      },
    );

    return await dio.post(
      _uriStorage.petUriString(UriPet.postIdPhoto, id: id),
      data: formData,
    );
  }
}

class DataServicesException implements Exception {
  final String message;

  DataServicesException(this.message);

  @override
  String toString() {
    return message;
  }
}

class DataServicesLoggedException extends DataServicesException {
  DataServicesLoggedException(String message) : super(message);
}

class DataServicesUnloggedException extends DataServicesException {
  DataServicesUnloggedException(String message) : super(message);
}
