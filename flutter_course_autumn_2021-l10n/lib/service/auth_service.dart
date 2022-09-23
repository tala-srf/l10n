import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_course_autumn_2021/model/auth_model.dart';
import 'package:flutter_course_autumn_2021/model/user_details_model.dart';
import 'package:flutter_course_autumn_2021/service/config.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<AuthModel?> authUser(AuthModel authModel) async {
    http.Response response = await http.post(
        Uri.parse('${ServiceConfig.base_url}/api/authenticate'),
        body: jsonEncode(authModel),
        headers: {'content-type': 'application/json;encode=utf-8'});
    http.Response res = response;
    if (response.statusCode == 200) {
      String? token =
          (jsonDecode(response.body) as Map<String, dynamic>)['id_token'];
      authModel.token = token;
      return authModel;
    } else if (response.statusCode == 401) {
      return null;
    }
  }

  userDetails(String username, String token) async {
    http.Response response = await http.get(
        Uri.parse('${ServiceConfig.base_url}/api/admin/users/$username'),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      UserDetailsModel userDetailsModel = UserDetailsModel.fromJson(
          (jsonDecode(response.body) as Map<String, dynamic>));
      return userDetailsModel;
    } else if (response.statusCode == 404) {
      return null;
    }
  }
}
