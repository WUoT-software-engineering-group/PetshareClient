import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:pet_share/models/pet.dart';

class DataServices {
  final String _baseUrl = 'https://pet-share-web-api-dev.azurewebsites.net';
  final String _pet = 'api/Pet';

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
