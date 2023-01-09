import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/data/model/food.dart';
import 'package:plan_meal_app/data/model/food_detect.dart';
import 'package:plan_meal_app/data/model/incompatable_ingredient.dart';
import 'package:plan_meal_app/data/model/ingredient_of_food.dart';
import 'package:plan_meal_app/data/repositories/abstract/food_repository.dart';
import 'package:dio/dio.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/utils.dart';

class FoodRepositoryRemote extends FoodRepository {
  @override
  Future<List<Food>> searchFoodList(String keyword) async {
    Dio dio = Dio();
    final parameters = {
      'order': 'ASC',
      'page': 1,
      'limit': 10,
      'search': keyword
    };
    var header = {'accept': 'application/json'};
    var route = ServerAddresses.serverAddress + ServerAddresses.food;
    final response = await dio.get(route,
        queryParameters: parameters, options: Options(headers: header));
    Map jsonResponse = response.data;
    if (response.statusCode == 200) {
      List<Food> foodList = [];
      var data = jsonResponse['data'] as List;
      for (var element in data) {
        var food = Food.fromJson(element);
        foodList.add(food);
      }
      return foodList;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw jsonResponse['message'];
    }
  }

  @override
  Future<String> addMealFood(
      String dishId,
      String type,
      String date,
      String mealId,
      String dishType,
      String individualShoppingListId,
      String note,
      {int quantity = 1}) async {
    try {
      Dio dio = Dio();
      var header = await HttpClient().createHeader();
      var route = ServerAddresses.serverAddress + ServerAddresses.addDish;
      var bodyData = {
        "dishId": dishId,
        "mealId": mealId,
        "type": type,
        "dishType": dishType,
        "date": date,
        "quantity": quantity,
        "note": note
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
  Future<Food> getFood(String dishId) async {
    Dio dio = Dio();
    var header = await HttpClient().createHeader();
    var route =
        ServerAddresses.serverAddress + ServerAddresses.food + '/$dishId';
    final response = await dio.get(route,
        options: Options(
          headers: header,
        ));
    Map jsonResponse = response.data;
    if (response.statusCode == 200) {
      var data = jsonResponse['data'] as Map<String, dynamic>;
      var food = Food.fromJson(data);
      return food;
    } else {
      throw jsonResponse['message'];
    }
  }

  @override
  Future<List<FoodDetect>> detectFood(String imageUrl) async {
    var dio = Dio();
    var header = {'accept': '*/*', 'Content-Type': 'application/json'};
    var route = ServerAddresses.serverAddress + ServerAddresses.classification;
    var bodyData = {"image": imageUrl};
    final response = await dio.post(route,
        data: bodyData, options: Options(headers: header));
    Map jsonResponse = response.data;
    if (response.statusCode == 201) {
      List<FoodDetect> listFoodDetect = [];
      var data = jsonResponse['data'] as List;
      for (var element in data) {
        var food = FoodDetect.fromJson(element);
        listFoodDetect.add(food);
      }
      return listFoodDetect;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw response.statusMessage ?? "";
    }
  }

  @override
  Future<String> addFood(String name, int carb, int fat, int protein,
      int calories, String imageUrl, String recipeId) async {
    var dio = Dio();
    var header = await HttpClient().createHeaderWithoutToken();
    var route = ServerAddresses.serverAddress + ServerAddresses.food;
    var bodyData = {
      "name": name,
      "carbohydrates": carb,
      "fat": fat,
      "protein": protein,
      "calories": calories,
      "cookingTime": 0,
      "imageUrl": imageUrl,
      "slug": "",
      "recipe": "",
      "description": ""
    };
    var response = await dio.post(route,
        data: bodyData,
        options: Options(
          headers: header,
        ));
    return response.statusCode.toString();
  }

  @override
  Future<String> updateFood(String id, String mealId, int quantity,
      String dishType, String note) async {
    var dio = Dio();
    var header = await HttpClient().createHeader();
    var route = ServerAddresses.serverAddress + ServerAddresses.updateDish;
    var bodyData = {
      "dishToMenuId": id,
      "mealId": mealId,
      "dishType": dishType,
      "quantity": quantity,
      "note": note
    };
    var response = await dio.patch(route,
        data: bodyData,
        options: Options(
          headers: header,
        ));
    return response.statusCode.toString();
  }

  @override
  Future<String> addMealFoodGroup(
      String groupId, String dishId, String type, String date, String mealId,
      {int quantity = 1}) async {
    try {
      Dio dio = Dio();
      var header = await HttpClient().createHeader();
      var route = ServerAddresses.serverAddress + ServerAddresses.addDishGroup;
      var bodyData = {
        "groupId": groupId,
        "dishId": dishId,
        "type": type,
        "date": date,
        "mealId": mealId,
        "quantity": quantity,
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
  Future<List<IngredientOfFood>> getIngredientByFood(String dishId) async {
    try {
      Dio dio = Dio();
      String route = ServerAddresses.serverAddress +
          ServerAddresses.foodIngredient +
          '/$dishId';
      var header = await HttpClient().createHeader();
      var response = await dio.get(route, options: Options(headers: header));
      Map jsonResponse = response.data;
      List<IngredientOfFood> listIngredient = [];
      if (response.statusCode == 200) {
        var data = jsonResponse['data'] as List;
        for (var element in data) {
          var ingredient = IngredientOfFood.fromJson(element);
          listIngredient.add(ingredient);
        }
      }
      return listIngredient;
    } on DioError catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<List<IncompatibleIngredient>> getIncompatibleIngredient(
      String ingredientId) async {
    try {
      Dio dio = Dio();
      String route = ServerAddresses.serverAddress +
          ServerAddresses.ingredientCompatible +
          '/$ingredientId';
      var header = await HttpClient().createHeader();
      var response = await dio.get(route, options: Options(headers: header));
      Map jsonResponse = response.data;
      List<IncompatibleIngredient> ingredientList = [];
      if (response.statusCode == 200) {
        var data = jsonResponse['data'] as List;
        for (var element in data) {
          var ingredient = IncompatibleIngredient.fromJson(element);
          ingredientList.add(ingredient);
        }
      }
      return ingredientList;
    } on DioError catch (exception) {
      throw Exception(exception);
    }
  }
}
