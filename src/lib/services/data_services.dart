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

class DataServices {
  late UriStorage _uriStorage;

  // ----------------------------------
  // Contstructors
  // ----------------------------------

  DataServices({bool dlps = false}) {
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

  Future<String> addAdopter(Adopter post, String accessToken) async {
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

  // -----------------------------------
  // Shelter methods
  // -----------------------------------

  Future<String> addShelter(Shelter post, String accessToken) async {
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

  // -----------------------------------
  // Announcement methods
  // -----------------------------------

  Future<List<Announcement>> getAnnouncements(String accessToken) async {
    http.Response res = await http.get(
      _uriStorage.announcementUri(UriAnnouncement.get),
      headers: buildHeader(accessToken),
    );

    try {
      if (res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body);
        return list.map((e) => Announcement.fromJson(e)).toList();
      } else {
        return <Announcement>[];
      }
    } catch (e) {
      log(e.toString());
      return <Announcement>[];
    }
  }

  Future<void> addAnnouncement(
    AnnouncementPost post,
    String accessToken,
  ) async {
    http.Response res = await http.post(
      _uriStorage.announcementUri(UriAnnouncement.post),
      headers: buildHeader(accessToken),
      body: post.toJson(),
    );

    if (res.statusCode != 200) {
      log('Something went wrong. The error is ${res.statusCode.toString()}');
      throw Exception('DataServices: addAnnouncement: wrong post.');
    }
  }

  // -----------------------------------
  // Pet methods
  // -----------------------------------

  Future<List<Pet>> getPets(String accessToken) async {
    http.Response res = await http.get(
      _uriStorage.petUri(UriPet.getShelterPets),
      headers: buildHeader(accessToken),
    );

    try {
      if (res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body);
        return list.map(((e) => Pet.fromJson(e))).toList();
      } else {
        return <Pet>[];
      }
    } catch (e) {
      log(e.toString());
      return <Pet>[];
    }
  }

  Future<List<Pet>> getPet(String id, String accessToken) async {
    http.Response res = await http.get(
      _uriStorage.petUri(UriPet.getId, id: id),
      headers: buildHeader(accessToken),
    );

    try {
      if (res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body);
        return list.map(((e) => Pet.fromJson(e))).toList();
      } else {
        return <Pet>[];
      }
    } catch (e) {
      log(e.toString());
      return <Pet>[];
    }
  }
}

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

  Future<List<Adopter2>> getAdopters(
    String accessToken,
  ) async {
    return <Adopter2>[];
  }

  // Future<Adopter2> getAdopterWithId(
  //   String accessToken,
  //   String adopterId,
  // ) async {
  //   return Adopter2(
  //     userName: "",
  //     phoneNumber: "",
  //     email: "email",
  //     address: Address(
  //       street: "",
  //       city: "",
  //       provice: "",
  //       postalCode: "",
  //       country: "",
  //     ),
  //   );
  // }

  Future<bool> getAdopterIsVerified(
    String accessToken,
    String adopterId,
  ) async {
    return false;
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
        return <Announcement2>[];
      }
    } catch (e) {
      log('DataServices: getAnnouncements: ${e.toString()}');
      return <Announcement2>[];
    }
  }

  // Future<Announcement2> getAnnouncementWithId(
  //   String accessToken,
  //   String announcementId,
  // ) async {
  //   return Announcement(
  //     id: "id",
  //     title: "title",
  //     description: "description",
  //     creationDate: DateTime.now(),
  //     closingDate: DateTime.now(),
  //     lastUpdateDate: DateTime.now(),
  //     status: 0,
  //     pet: Pet(
  //         id: "",
  //         shelterID: "shelterID",
  //         name: "name",
  //         species: "species",
  //         breed: "breed",
  //         birthday: DateTime.now(),
  //         description: "",
  //         photo: ""),
  //     author: Author(
  //       id: "id",
  //       userName: "userName",
  //       phoneNumer: "phoneNumer",
  //       email: "email",
  //       fullShelterName: "fullShelterName",
  //       isAuthorized: false,
  //       adress: Address(
  //           street: "street",
  //           city: "city",
  //           provice: "provice",
  //           postalCode: "postalCode",
  //           country: "country"),
  //     ),
  //   );
  // }

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

  // -----------------------------------
  // Pet methods
  // -----------------------------------

  // Future<Pet2> getPetWithId(
  //   String accessToken,
  //   String petId,
  // ) async {
  //   return Pet2(
  //     id: "id",
  //     shelterID: "shelterID",
  //     name: "name",
  //     species: "species",
  //     breed: "breed",
  //     birthday: DateTime.now(),
  //     description: "description",
  //     photo: "photo",
  //   );
  // }

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
        await uploadImage(res.headers['location']!, accessToken, pet.image);

        return true;
      } else {
        log('DataServices: postPet: bad:  ${res.statusCode} :: ${res.body}');
        return false;
      }
    } catch (e) {
      log('DataServices: postPet: ${e.toString()}');
      return false;
    }
  }

  Future<void> uploadImage(
    //String title,
    String id,
    String accessToken,
    XFile file,
  ) async {
    var request = http.MultipartRequest(
        'POST', _uriStorage.petUri(UriPet.postIdPhoto, id: id));
    request.headers.addAll(buildHeader(accessToken));

    var bytes = await file.readAsBytes();
    request.fields['file'] = bytes.toString();
    var picture =
        http.MultipartFile.fromBytes('image', bytes, filename: 'tsttest.png');

    request.files.add(picture);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);
    log('code : ${response.statusCode}');
    log(result);
  }

  // -----------------------------------
  // Shelter methods
  // -----------------------------------

  Future<List<Shelter2>> getShelters(
    String accessToken,
  ) async {
    return <Shelter2>[];
  }

  // Future<Shelter> getShelterWithId(
  //   String accessToken,
  //   String shelterId,
  // ) async {
  //   return Shelter(
  //     userName: "userName",
  //     phoneNumber: "phoneNumber",
  //     email: "email",
  //     fullShelterName: "fullShelterName",
  //     address: Address(
  //         street: "street",
  //         city: "city",
  //         provice: "provice",
  //         postalCode: "postalCode",
  //         country: "country"),
  //   );
  // }

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
}
