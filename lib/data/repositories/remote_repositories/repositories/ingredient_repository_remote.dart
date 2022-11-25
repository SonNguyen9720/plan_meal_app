import 'package:dio/dio.dart';
import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/data/model/ingredient.dart';
import 'package:plan_meal_app/data/repositories/abstract/ingredient_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/utils.dart';

class IngredientRepositoryRemote extends IngredientRepository {
  @override
  Future<List<Ingredient>> searchIngredient(String keyword) async {
    var dio = Dio();
    final parameters = {
      'order': 'ASC',
      'page': 1,
      'limit': 10,
      'search': keyword
    };
    var header = await HttpClient().createGetHeader();
    var route = ServerAddresses.serverAddress + ServerAddresses.ingredient;
    final response = await dio.get(route,
        options: Options(headers: header), queryParameters: parameters);
    Map jsonResponse = response.data;
    if (response.statusCode == 200) {
      List<Ingredient> listFoodDetect = [];
      var data = jsonResponse['data'] as List;
      for (var element in data) {
        var food = Ingredient.fromJson(element);
        listFoodDetect.add(food);
      }
      return listFoodDetect;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw response.statusMessage ?? "";
    }
  }
}
