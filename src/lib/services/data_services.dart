import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pet_share/models/pet.dart';

import '../models/announcement.dart';

class DataServices {
  final String _baseUrl = 'https://pet-share-web-api-dev.azurewebsites.net';
  final String _pet = 'api/Pet';
  final String _announcement = 'api/Announcement';
  final Map<String, String> _jsonHeader = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  Future<List<Announcement>> getAnnouncements() async {
    http.Response res = await http.get(Uri.parse('$_baseUrl/$_announcement'));

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

  Future<void> addAnnouncement(AnnouncementPost post) async {
    http.Response res = await http.post(Uri.parse('$_baseUrl/$_announcement'),
        headers: _jsonHeader, body: _announcementPostToJson(post));

    if (res.statusCode != 200) {
      log('Something went wrong. The error is ${res.statusCode.toString()}');
    }
  }

  String _announcementPostToJson(AnnouncementPost post) {
    String date =
        '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(post.pet!.birthday).toString()}Z';

    return jsonEncode(<String, dynamic>{
      'title': post.title,
      'description': post.description,
      'pet': <String, dynamic>{
        'name': post.pet!.name,
        'species': post.pet!.species,
        'breed': post.pet!.breed,
        'birthday': date,
        'description': post.pet!.description,
        'photo': post.pet!.photo.toString()
      }
    });
  }

  Future<List<Pet>> getPets() async {
    http.Response res = await http.get(Uri.parse('$_baseUrl/$_pet'));

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

  Future<List<Pet>> getPet(int id) async {
    http.Response res =
        await http.get(Uri.parse('$_baseUrl/$_pet/${id.toString()}'));

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
