import 'dart:convert';

import 'package:flutter_course_autumn_2021/model/locations_model.dart';
import 'package:flutter_course_autumn_2021/service/config.dart';
import 'package:http/http.dart' as http;

class LocationsService {
  Future<List<LocationsModel>> getAllLocations(String token,
      {int? page, int? size}) async {
    if (token == 'EMPTY_TOKEN') throw Exception();
    http.Response response = await http.get(
        Uri.parse(
            '${ServiceConfig.base_url}/api/locations?page=$page&size=$size'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    List locations = jsonDecode(response.body) as List;
    return locations
        .map((e) => LocationsModel.fromJson(e))
        .toList(growable: true);
  }
}
