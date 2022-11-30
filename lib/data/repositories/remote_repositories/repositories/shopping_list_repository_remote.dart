import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/data/model/ingredient_by_day.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/utils.dart';
import 'package:http/http.dart' as http;


class ShoppingListRepositoryRemote extends ShoppingListRepository {
  @override
  Future<String> addIngredient(String id, String name, int quantity, int weight, String measurementType, String type, String date) async {
    var dio = Dio();
    var header = await HttpClient().createHeader();
    var route = ServerAddresses.serverAddress + ServerAddresses.addIngredientToShoppingList;
    var bodyData = {
      "ingredientId": id,
      "date": date,
      "quantity": quantity,
      "weight": weight,
      "measurementType": measurementType,
      "type": type
    };
    var response = await dio.post(route, data: bodyData, options: Options(
      headers: header,
    ));
    return response.statusCode.toString();
  }

  @override
  Future<List<IngredientByDay>> getIngredient(String date) async {
    var header = await HttpClient().createHeader();
    var formattedDate = HttpClient.parseToHtmlDate(date);

    String url = ServerAddresses.serverAddress +
        ServerAddresses.shoppingList + '/' +
        formattedDate;
    var uri = Uri.parse(url);
    final response = await http.get(uri, headers: header);
    Map jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      List<IngredientByDay> ingredientList = [];
      var data = jsonResponse['data'] as List;
      for (var element in data) {
        var ingredient = IngredientByDay.fromJson(element);
        ingredientList.add(ingredient);
      }
      return ingredientList;
    } else if (response.statusCode == 400) {
      return [];
    } else {
      throw jsonResponse['message'];
    }
  }

  @override
  Future<String> removeIngredient(String id, String date) async {
    Dio dio = Dio();
    var header = await HttpClient().createHeader();
    String route = ServerAddresses.serverAddress + ServerAddresses.removeIngredientShoppingList;
    var bodyData = {
      'ingredientToShoppingListId': id,
      'date': date
    };
    final response = await dio.post(route, data: bodyData, options: Options(
      headers: header,
    ));
    return response.statusCode.toString();
  }

  @override
  Future<String> checkIngredient(String id) async {
    Dio dio = Dio();
    var header = await HttpClient().createHeader();
    String route = ServerAddresses.serverAddress + ServerAddresses.checkIngredient;
    Map bodyData = {
      'ingredientToShoppingListId': id
    };
    final response = await dio.post(route, data: bodyData, options: Options(
      headers: header,
    ));
    return response.statusCode.toString();
  }

  @override
  Future<String> uncheckIngredient(String id) async {
    Dio dio = Dio();
    var header = await HttpClient().createHeader();
    String route = ServerAddresses.serverAddress + ServerAddresses.uncheckIngredient;
    Map bodyData = {
      'ingredientToShoppingListId': id
    };
    final response = await dio.post(route, data: bodyData, options: Options(
      headers: header,
    ));
    return response.statusCode.toString();
  }

  @override
  Future<String> updateIngredient(String id, int quantity, int weight, String measurementType) async {
    Dio dio = Dio();
    var header = await HttpClient().createHeader();
    String route = ServerAddresses.serverAddress + ServerAddresses.updateIngredient;
    Map bodyData = {
      "ingredientToShoppingListId": id,
      "quantity": quantity,
      "weight": weight,
      "measurementType": measurementType
    };
    final response = await dio.patch(route, data: bodyData, options: Options(
      headers: header,
    ));
    return response.statusCode.toString();
  }
}