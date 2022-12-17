import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/data/model/food_meal.dart';
import 'package:plan_meal_app/data/repositories/abstract/menu_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/utils.dart';
import 'package:http/http.dart' as http;

class MenuRepositoryRemote extends MenuRepository {
  @override
  Future<List<FoodMeal>> getMealByDay(String date) async {
    var header = await HttpClient().createHeader();
    var formattedDate = HttpClient.parseToHtmlDate(date);

    String url = ServerAddresses.serverAddress +
        ServerAddresses.menuDetail +
        formattedDate;
    var uri = Uri.parse(url);
    final response = await http.get(uri, headers: header);
    Map jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      List<FoodMeal> foodMealList = [];
      var data = jsonResponse['data'] as List;
      for (var element in data) {
        var food = FoodMeal.fromJson(element);
        foodMealList.add(food);
      }
      return foodMealList;
    } else if (response.statusCode == 400) {
      return [];
    } else {
      throw jsonResponse['message'];
    }
  }

  @override
  Future<String> removeFoodFromMenu(
      String foodId) async {
    try {
      Dio dio = Dio();
      var header = await HttpClient().createHeader();
      String route = ServerAddresses.serverAddress + ServerAddresses.removeDish;
      var bodyData = {
        "dishToMenuId": foodId,
      };
      final response = await dio.post(route,
          data: bodyData,
          options: Options(
            headers: header,
          ));
      return response.statusCode.toString();
    } on DioError catch (exception) {
      if (exception.response != null) {
        return exception.response?.statusMessage ??
            "Something error please try again";
      }
      return exception.message;
    }
  }

  @override
  Future<String> trackFood(String dishToMenuId) async {
    var dio = Dio();
    var header = await HttpClient().createHeader();
    var route = ServerAddresses.serverAddress + ServerAddresses.trackDish;
    var bodyData = {"dishToMenuId": dishToMenuId};
    final response = await dio.post(route,
        data: bodyData,
        options: Options(
          headers: header,
        ));
    return response.statusCode.toString();
  }

  @override
  Future<List<FoodMeal>> getMealByGroupByDay(
      String date, String groupId) async {
    Dio dio = Dio();
    var header = await HttpClient().createGetHeader();
    String route = ServerAddresses.serverAddress + ServerAddresses.menuGroup;

    Map<String, String> queryParams = {'date': date, 'groupId': groupId};

    final response = await dio.get(route,
        queryParameters: queryParams,
        options: Options(
          headers: header,
        ));
    if (response.statusCode == 200) {
      List<FoodMeal> foodMealList = [];
      var data = response.data['data'] as List;
      for (var element in data) {
        var foodMeal = FoodMeal.fromJson(element);
        foodMealList.add(foodMeal);
      }
      return foodMealList;
    } else {
      throw response.statusCode.toString();
    }
  }

  @override
  Future<String> untrackFood(String dishToMenuId) async {
    var dio = Dio();
    var header = await HttpClient().createHeader();
    var route = ServerAddresses.serverAddress + ServerAddresses.untrackDish;
    var bodyData = {"dishToMenuId": dishToMenuId};
    final response = await dio.post(route,
        data: bodyData,
        options: Options(
          headers: header,
        ));
    return response.statusCode.toString();
  }

  @override
  Future<String> suggestMeal(String date) async {
    try {
      Dio dio = Dio();
      String route =
          ServerAddresses.serverAddress + ServerAddresses.recommendFood;
      var queryParameter = {
        'date': date,
      };
      var header = await HttpClient().createHeader();
      var response = await dio.post(route,
          options: Options(headers: header), queryParameters: queryParameter);
      return response.statusCode.toString();
    } on DioError catch (exception) {
      throw Exception(exception.message);
    }
  }
}
