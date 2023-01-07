import 'package:dio/dio.dart';
import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/data/model/ingredient.dart';
import 'package:plan_meal_app/data/model/location.dart';
import 'package:plan_meal_app/data/repositories/abstract/ingredient_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/utils.dart';

class IngredientRepositoryRemote extends IngredientRepository {
  @override
  Future<List<Ingredient>> searchIngredient(String keyword, int page) async {
    var dio = Dio();
    final parameters = {
      'order': 'DESC',
      'page': page,
      'limit': 20,
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

  @override
  Future<List<Location>> searchLocation(String keyword, int page) async {
    Dio dio = Dio();
    final parameters = {
      'order': 'ASC',
      'page': page,
      'limit': 20,
      'search': keyword
    };
    var header = await HttpClient().createGetHeader();
    String route = ServerAddresses.serverAddress + ServerAddresses.location;
    final response = await dio.get(route, options: Options(headers: header), queryParameters: parameters);
    Map jsonResponse = response.data;
    List<Location> locationList = [];
    if (response.statusCode == 200) {
      var data = jsonResponse['data'] as List;
      for (var element in data) {
        var location = Location.fromJson(element);
        locationList.add(location);
      }
    }
    return locationList;
  }

  @override
  Future<String> addLocation(String location) async {
    try {
      Dio dio = Dio();
      String route = ServerAddresses.serverAddress + ServerAddresses.location;
      Map<String, dynamic> bodyData = {
        'name': location,
      };
      var header = await HttpClient().createHeader();
      var response = await dio.post(route, options: Options(headers: header), data: bodyData);
      return response.statusCode.toString();
    } on DioError catch (exception) {
      throw Exception(exception.message);
    }
  }
}
