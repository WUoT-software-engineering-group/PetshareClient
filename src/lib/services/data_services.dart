import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:pet_share/models/adopter.dart';
import 'package:pet_share/models/announcement.dart';
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
