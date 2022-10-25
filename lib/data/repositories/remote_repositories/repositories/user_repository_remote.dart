import 'dart:convert';

import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/data/model/app_user.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:http/http.dart' as http;

class UserRepositoryRemote extends UserRepository {
  @override
  Future<AppUser> getUser() async {
    //
    throw UnimplementedError();
  }

  @override
  Future<String> signIn(
      {required String email, required String password}) async {
    var route =
        Uri.parse(ServerAddresses.serverAddress + ServerAddresses.authToken);
    var data = <String, String>{
      'email': email,
      'password': password,
    };

    var response = await http.post(route, body: data);
    Map jsonResponse = json.decode(response.body);
    if (response.statusCode == 201) {
      return jsonResponse['data'][0]['accessToken'];
    } else {
      throw jsonResponse['message'];
    }
  }

  @override
  Future<String> signUp(
      {required String email, required String password}) async {
    var route =
        Uri.parse(ServerAddresses.serverAddress + ServerAddresses.signUp);

    var data = <String, String>{
      'email': email,
      'password': password,
    };

    var response = await http.post(route, body: data);
    Map jsonResponse = json.decode(response.body);
    if (response.statusCode == 201) {
      return jsonResponse['data'][0]['accessToken'];
    } else if (response.statusCode == 403) {
      throw "Email already exists";
    } else {
      throw jsonResponse['message'];
    }
  }
}
