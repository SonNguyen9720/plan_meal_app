import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/data/model/food.dart';
import 'package:plan_meal_app/data/repositories/abstract/food_repository.dart';
import 'package:dio/dio.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/ultis.dart';

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
  Future<String> addMealFood(String dishId, DateTime date, String meal,
      {int quantity = 1}) async {
    try {
      Dio dio = Dio();
      var header = await HttpClient().createHeader();
      var route = ServerAddresses.serverAddress + ServerAddresses.addDish;
      var bodyData = {
        "dishId": dishId,
        "date": date,
        "meal": meal,
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
}
