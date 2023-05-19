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
      log('Something went wrong. The error is ${res.statusCode.toString()}');
      throw Exception('DataServices: addAdopter: http.post error!');
    }

    log('DataServices: addAdopter: http post is done correctly.');
    return idToken;
  }

  Future<List<Adopter2>> getAdopters(
    String accessToken,
  ) async {
    http.Response res = await http.get(
      _uriStorage.adopterUri(UriAdopter.get),
      headers: buildHeader(accessToken),
    );

    try {
      if (res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body);
        return list.map((e) => Adopter2.fromJson(e)).toList();
      } else {
        log('DataServices: getAdopters: bad get:  ${res.statusCode} :: ${res.body}');
        return <Adopter2>[];
      }
    } catch (e) {
      log('DataServices: getAdopters: ${e.toString()}');
      return <Adopter2>[];
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
      log('Something went wrong. The error is ${res.statusCode.toString()}');
      throw Exception('DataServices: addShelter: http.post error!');
    }

    log('DataServices: addShelter: http post is done correctly.');
    return idToken;
  }

  Future<List<Pet2>> getShelterPets(
    String accessToken,
  ) async {
    http.Response res = await http.get(
      _uriStorage.petUri(UriPet.getShelterPets),
      headers: buildHeader(accessToken),
    );

    try {
      if (res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body);
        return list.map((e) => Pet2.fromJson(e)).toList();
      } else {
        log('DataServices: getShelterPets: bad: ${res.statusCode} :: ${res.body}');
        return <Pet2>[];
      }
    } catch (e) {
      log('DataServices: getShelterPets: ${e.toString()}');
      return <Pet2>[];
    }
  }

  Future<List<Announcement2>> getShelterAnnouncements(
    String accessToken,
  ) async {
    http.Response res = await http.get(
      _uriStorage.announcementUri(UriAnnouncement.getShelterAnnouncements),
      headers: buildHeader(accessToken),
    );

    try {
      if (res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body);
        return list.map((e) => Announcement2.fromJson(e)).toList();
      } else {
        log('DataServices: getShelterAnnouncements: bad');
        return <Announcement2>[];
      }
    } catch (e) {
      log('DataServices: getShelterAnnouncements: ${e.toString()}');
      return <Announcement2>[];
    }
  }

  // -----------------------------------
  // Announcement methods
  // -----------------------------------

  Future<List<Announcement2>> getAnnouncements(
    String accessToken,
  ) async {
    http.Response res = await http.get(
      _uriStorage.announcementUri(UriAnnouncement.get),
      headers: buildHeader(accessToken),
    );

    try {
      if (res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body);
        return list.map((e) => Announcement2.fromJson(e)).toList();
      } else {
        log('DataServices: getAnnouncements: bad get:  ${res.statusCode} :: ${res.body}');
        return <Announcement2>[];
      }
    } catch (e) {
      log('DataServices: getAnnouncements: ${e.toString()}');
      return <Announcement2>[];
    }
  }

  Future<bool> postAnnouncement(
    String accessToken,
    CreatingAnnouncement2 announcement,
  ) async {
    http.Response res = await http.post(
      _uriStorage.announcementUri(UriAnnouncement.post),
      headers: buildHeader(accessToken),
      body: announcement.toJson(),
    );

    try {
      if (res.statusCode == 201) {
        return true;
      } else {
        log('DataServices: postAnnouncement: bad get:  ${res.statusCode} :: ${res.body}');
        return false;
      }
    } catch (e) {
      log('DataServices: postAnnouncement: ${e.toString()}');
      return false;
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

    try {
      if (res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body);
        return list.map((e) => Appplications2.fromJson(e)).toList();
      } else {
        log('DataServices: getApplications: bad');
        return <Appplications2>[];
      }
    } catch (e) {
      log('DataServices: getApplications: ${e.toString()}');
      return <Appplications2>[];
    }
  }

  Future<bool> postApplication(
    String accessToken,
    String announcementId,
    String adopterId,
  ) async {
    http.Response res = await http.post(
      _uriStorage.applicationsUri(UriApplications.post),
      headers: buildHeader(accessToken),
      body: jsonEncode({
        'announcementId': announcementId,
        'adopterId': adopterId,
      }),
    );

    try {
      if (res.statusCode == 201) {
        return true;
      } else {
        log('DataServices: postApplication: bad post application:  ${res.statusCode} :: ${res.body}');
        return false;
      }
    } catch (e) {
      log('DataServices: postApplication: ${e.toString()}');
      return false;
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

  Future<bool> putAcceptApplication(
    String accessToken,
    String applicationId,
  ) async {
    http.Response res = await http.put(
      _uriStorage.applicationsUri(UriApplications.putIdAccept),
      headers: buildHeader(accessToken),
    );

    try {
      if (res.statusCode == 200) {
        return true;
      } else {
        log('DataServices: putAcceptApplication: bad accept application:  ${res.statusCode} :: ${res.body}');
        return false;
      }
    } catch (e) {
      log('DataServices: putAcceptApplication: ${e.toString()}');
      return false;
    }
  }

  Future<bool> putRejectApplication(
    String accessToken,
    String applicationId,
  ) async {
    http.Response res = await http.put(
      _uriStorage.applicationsUri(UriApplications.putIdReject),
      headers: buildHeader(accessToken),
    );

    try {
      if (res.statusCode == 200) {
        return true;
      } else {
        log('DataServices: putRejectApplication: bad reject application:  ${res.statusCode} :: ${res.body}');
        return false;
      }
    } catch (e) {
      log('DataServices: putRejectApplication: ${e.toString()}');
      return false;
    }
  }

  // -----------------------------------
  // Pet methods
  // -----------------------------------

  Future<bool> postPet(
    String accessToken,
    CreatingPet2 pet,
  ) async {
    http.Response res = await http.post(
      _uriStorage.petUri(UriPet.post),
      headers: buildHeader(accessToken),
      body: pet.toJson(),
    );

    try {
      if (res.statusCode == 201) {
        var response = await uploadPetImage(
          res.headers['location']!,
          accessToken,
          pet.image,
        );

        if (response.statusCode == 200) {
          return true;
        } else {
          log('DataServices: postPet: bad post pet image:  ${response.statusCode}');
          return false;
        }
      } else {
        log('DataServices: postPet: bad post pet:  ${res.statusCode} :: ${res.body}');
        return false;
      }
    } catch (e) {
      log('DataServices: postPet: ${e.toString()}');
      return false;
    }
  }

  Future<Response<dynamic>> uploadPetImage(
    String id,
    String accessToken,
    XFile file,
  ) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    Dio dio = Dio();

    var header = buildHeader(accessToken);
    header.forEach((key, value) {
      dio.options.headers[key] = value;
    });

    return await dio.post(
      _uriStorage.petUriString(UriPet.postIdPhoto, id: id),
      data: formData,
    );
  }
}
