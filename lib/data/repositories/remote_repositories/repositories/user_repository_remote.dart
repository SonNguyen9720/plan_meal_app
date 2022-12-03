import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/data/model/bmi.dart';
import 'package:plan_meal_app/data/model/user_info.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:plan_meal_app/data/repositories/remote_repositories/utils.dart';

class UserRepositoryRemote extends UserRepository {
  @override
  Future<UserInfo> getUser() async {
    Dio dio = Dio();
    var route = ServerAddresses.serverAddress + ServerAddresses.getUser;
    var header = await HttpClient().createGetHeader();
    final response = await dio.get(route, options: Options(headers: header));
    if (response.statusCode == 200) {
      var data = response.data['data'];
      UserInfo user = UserInfo.fromJson(data);
      return user;
    } else {
      throw response.statusCode.toString();
    }
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
      return jsonResponse['data']['accessToken'];
    } else if (response.statusCode == 403) {
      throw "Username or password is not exist";
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
      return jsonResponse['data']['accessToken'];
    } else if (response.statusCode == 403) {
      throw "Email already exists";
    } else {
      throw jsonResponse['message'];
    }
  }

  @override
  Future<BMI> getBMI() async {
    Dio dio = Dio();
    var header = await HttpClient().createGetHeader();
    String route = ServerAddresses.serverAddress + ServerAddresses.bmi;
    final response = await dio.get(route, options: Options(
      headers: header,
    ));
    if (response.statusCode == 200) {
      var data = response.data['data'];
      var result = BMI.fromJson(data);
      return result;
    } else {
      throw "Error API";
    }
  }
}
