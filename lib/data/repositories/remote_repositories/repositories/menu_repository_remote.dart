import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/data/model/food_meal.dart';
import 'package:plan_meal_app/data/repositories/abstract/menu_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/ultis.dart';
import 'package:http/http.dart' as http;

class MenuRepositoryRemote extends MenuRepository {
  @override
  Future<List<FoodMeal>> getMealByDay(String date) async {
    Dio dio = Dio();
    var header = await HttpClient().createHeader();
    var formattedDate = date.replaceAll('/', '%2F');

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
}
