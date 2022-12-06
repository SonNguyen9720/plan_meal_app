import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/data/model/bmi.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/data/model/user_info.dart';
import 'package:plan_meal_app/data/model/user_overview.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:plan_meal_app/data/repositories/remote_repositories/utils.dart';

class UserRepositoryRemote extends UserRepository {
  @override
  Future<UserInfo?> getUser() async {
    try {
      Dio dio = Dio();
      var route = ServerAddresses.serverAddress + ServerAddresses.getUser;
      var header = await HttpClient().createGetHeader();
      final response = await dio.get(route, options: Options(headers: header));
      var data = response.data['data'];
      UserInfo user = UserInfo.fromJson(data);
      return user;
    } on DioError catch (exception) {
      if (exception.response?.statusCode == 401) {
        throw Exception(exception.response!.statusMessage!);
      }
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
    final response = await dio.get(route,
        options: Options(
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

  @override
  Future<UserOverview> getOverview(String date) async {
    Dio dio = Dio();
    String route = ServerAddresses.serverAddress + ServerAddresses.userOverview;
    var header = await HttpClient().createGetHeader();
    Map<String, dynamic> queryParams = {
      'date': date,
    };
    final response = await dio.get(route,
        queryParameters: queryParams, options: Options(headers: header));
    if (response.statusCode == 200) {
      var data = response.data['data'];
      var result = UserOverview.fromJson(data);
      return result;
    }
    throw "Error Api";
  }

  @override
  Future<String> updateWeight(int weight) async {
    Dio dio = Dio();
    String route = ServerAddresses.serverAddress + ServerAddresses.weightRecord;
    var header = await HttpClient().createGetHeader();
    Map<String, dynamic> bodyData = {
      'weight': weight,
    };
    final response = await dio.patch(route,
        data: bodyData, options: Options(headers: header));
    return response.statusCode.toString();
  }

  @override
  Future<String> updateUserInfo(
      {required int id,
      required String firstName,
      required String lastName,
      required String sex,
      required String dob,
      required int height,
      required int weight,
      required int age,
      required String imageUrl,
      required String healthGoal,
      required int desiredWeight,
      required String activityIntensity,
      required String email}) async {
    Dio dio = Dio();
    String route = ServerAddresses.serverAddress + ServerAddresses.user + '/$id';
    var header = await HttpClient().createGetHeader();
    Map<String, dynamic> bodyData = {
      "firstName": firstName,
      "lastName": lastName,
      "sex": sex,
      "dob": dob,
      "height": height,
      "weight": weight,
      "age": age,
      "imageUrl": imageUrl,
      "healthGoal": healthGoal,
      "desiredWeight": desiredWeight,
      "activityIntensity": activityIntensity,
      "email": email
    };
    final response = await dio.patch(route, data: bodyData, options: Options(headers: header));
    return response.statusCode.toString();
  }

  @override
  Future<String> postUserProfile(User user, String email, String token) async {
    Dio dio = Dio();
    String route = ServerAddresses.serverAddress + ServerAddresses.getUser;
    var header = <String, String>{
      'Authorization' : 'Bearer ' + token,
      'Content-Type' : 'application/json'
    };
    Map<String, dynamic> bodyData = {
      "firstName": user.firstName,
      "lastName": user.lastName,
      "sex": user.gender,
      "dob": user.birthday,
      "height": user.height,
      "weight": user.currentWeight,
      "age": user.age,
      "imageUrl": user.imageUrl,
      "healthGoal": user.userGoal,
      "desiredWeight": user.goalWeight,
      "activityIntensity": user.activityIntensity,
      "email": email,
    };
    final response = await dio.post(route, data: bodyData, options: Options(
      headers: header,
    ));
    return response.statusCode.toString();
  }

  @override
  Future<String> changePassword(String oldPassword, String newPassword) async {
    try {
      Dio dio = Dio();
      var header = await HttpClient().createHeader();
      var route = ServerAddresses.serverAddress + ServerAddresses.changePassword;
      var bodyData = {
        "oldPassword": oldPassword,
        "newPassword": newPassword
      };
      final response = await dio.patch(route, data: bodyData, options: Options(headers: header));
      return response.statusCode.toString();
    } catch (exception) {
      if (exception is DioError) {
        if (exception.response!.statusCode == 400) {
          return exception.response!.data['message'];
        }
        return exception.message;
      }
      return "There is something error";
    }
  }
}
