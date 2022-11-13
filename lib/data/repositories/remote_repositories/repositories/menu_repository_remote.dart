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
      String foodId, String date, String meal) async {
    try {
      Dio dio = Dio();
      var header = await HttpClient().createHeader();
      String route = ServerAddresses.serverAddress + ServerAddresses.removeDish;
      var bodyData = {
        "dishId": foodId,
        "date": date,
        "meal": meal,
      };
      final response = await dio.post(route, data: bodyData, options: Options(
        headers: header,
      ));
      return response.statusMessage ?? "Null exception";
    } on DioError catch (exception) {
      if (exception.response != null) {
        return exception.response?.statusMessage ??
            "Something error please try again";
      }
      return exception.message;
    }
  }
}
