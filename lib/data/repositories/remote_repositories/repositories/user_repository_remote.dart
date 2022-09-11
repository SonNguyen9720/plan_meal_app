import 'dart:convert';

import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/data/model/app_user.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/ultis.dart';
import 'package:http/http.dart' as http;

class UserRepositoryRemote extends UserRepository {
  @override
  Future<AppUser> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<String> signIn(
      {required String email, required String password}) async {
    var route = HttpClient().createUri(ServerAddresses.authToken);
    var data = <String, String>{
      'username': email,
      'password': password,
    };

    var response = await http.post(route, body: data);
    Map jsonResponse = json.decode(response.body);
    if (response.statusCode != 200) {
      throw jsonResponse['message'];
    }
    return jsonResponse['token'];
  }

  @override
  Future<String> signUp({required String email, required String password}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
