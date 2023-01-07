import 'package:dio/dio.dart';
import 'package:plan_meal_app/config/server_addresses.dart';
import 'package:plan_meal_app/data/model/ingredient_by_day.dart';
import 'package:plan_meal_app/data/model/shopping_list.dart';
import 'package:plan_meal_app/data/model/shopping_list_detail.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/utils.dart';

class ShoppingListRepositoryRemote extends ShoppingListRepository {
  @override
  Future<String> addIngredient(String ingredientId, String date, int quantity,
      String measurementTypeId, String locationId, String note) async {
    var dio = Dio();
    var header = await HttpClient().createHeader();
    var route = ServerAddresses.serverAddress +
        ServerAddresses.addIngredientToShoppingList;
    var bodyData = {
      "ingredientId": ingredientId,
      "date": date,
      "quantity": quantity,
      "measurementTypeId": measurementTypeId,
      "locationId": locationId,
      "note": note
    };
    var response = await dio.post(route,
        data: bodyData,
        options: Options(
          headers: header,
        ));
    return response.statusCode.toString();
  }

  @override
  Future<List<IngredientByDay>> getIngredient(
      String dateStart, String dateEnd) async {
    try {
      Dio dio = Dio();
      var header = await HttpClient().createHeader();
      String route =
          ServerAddresses.serverAddress + ServerAddresses.getIngredient;
      Map<String, dynamic> queryParams = {
        'fromDate': dateStart,
        'toDate': dateEnd,
      };
      var response = await dio.get(route,
          queryParameters: queryParams, options: Options(headers: header));
      Map jsonResponse = response.data;
      List<IngredientByDay> ingredientList = [];
      if (response.statusCode == 200) {
        var data = jsonResponse['data'] as List;
        for (var element in data) {
          var ingredient = IngredientByDay.fromJson(element);
          ingredientList.add(ingredient);
        }
      }
      return ingredientList;
    } on DioError catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<String> removeIngredient(String id) async {
    Dio dio = Dio();
    var header = await HttpClient().createHeader();
    String route = ServerAddresses.serverAddress +
        ServerAddresses.removeIngredientShoppingList;
    var bodyData = {'ingredientToShoppingListId': id};
    final response = await dio.post(route,
        data: bodyData,
        options: Options(
          headers: header,
        ));
    return response.statusCode.toString();
  }

  @override
  Future<String> checkIngredient(String id) async {
    Dio dio = Dio();
    var header = await HttpClient().createHeader();
    String route =
        ServerAddresses.serverAddress + ServerAddresses.checkIngredient;
    Map bodyData = {'ingredientToShoppingListId': id};
    final response = await dio.post(route,
        data: bodyData,
        options: Options(
          headers: header,
        ));
    return response.statusCode.toString();
  }

  @override
  Future<String> uncheckIngredient(String id) async {
    Dio dio = Dio();
    var header = await HttpClient().createHeader();
    String route =
        ServerAddresses.serverAddress + ServerAddresses.uncheckIngredient;
    Map bodyData = {'ingredientToShoppingListId': id};
    final response = await dio.post(route,
        data: bodyData,
        options: Options(
          headers: header,
        ));
    return response.statusCode.toString();
  }

  @override
  Future<String> updateIngredient(
      String id, int quantity, String measurementTypeId, String locationId, String note) async {
    Dio dio = Dio();
    var header = await HttpClient().createHeader();
    String route =
        ServerAddresses.serverAddress + ServerAddresses.updateIngredient;
    Map bodyData = {
      "ingredientToShoppingListId": id,
      "quantity": quantity,
      "measurementTypeId": measurementTypeId,
      "locationId": locationId,
      "note": note
    };
    final response = await dio.patch(route,
        data: bodyData,
        options: Options(
          headers: header,
        ));
    return response.statusCode.toString();
  }

  @override
  Future<List<IngredientByDay>> getGroupIngredient(
      String groupId, String dateStart, String dateEnd) async {
    Dio dio = Dio();
    var header = await HttpClient().createGetHeader();
    String route =
        ServerAddresses.serverAddress + ServerAddresses.getGroupIngredient;
    Map<String, dynamic> queryParam = {'fromDate': dateStart, 'toDate': dateEnd, 'groupId': groupId};
    final response = await dio.get(route,
        queryParameters: queryParam, options: Options(headers: header));
    if (response.statusCode == 200) {
      List<IngredientByDay> ingredientList = [];
      var data = response.data['data'] as List;
      for (var element in data) {
        var ingredient = IngredientByDay.fromJson(element);
        ingredientList.add(ingredient);
      }
      return ingredientList;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw response.statusCode.toString();
    }
  }

  @override
  Future<String> addGroupIngredient(
      String groupId,
      String ingredientId,
      String date,
      int quantity,
      String measurementTypeId,
      String location,
      String note) async {
    var dio = Dio();
    var header = await HttpClient().createHeader();
    var route = ServerAddresses.serverAddress +
        ServerAddresses.addGroupIngredientToShoppingList;
    var bodyData = {
      "groupId": groupId,
      "ingredientId": ingredientId,
      "date": date,
      "quantity": quantity,
      "measurementTypeId": measurementTypeId,
      "note": note,
    };
    var response = await dio.post(route,
        data: bodyData,
        options: Options(
          headers: header,
        ));
    return response.statusCode.toString();
  }

  @override
  Future<ShoppingListDetail?> getShoppingListDetail(
      String date, String groupId) async {
    try {
      Dio dio = Dio();
      var header = await HttpClient().createGetHeader();
      var route =
          ServerAddresses.serverAddress + ServerAddresses.shoppingListDetail;
      Map<String, dynamic> queryParams = {"date": date, "groupId": groupId};
      final response = await dio.get(route,
          queryParameters: queryParams, options: Options(headers: header));
      if (response.statusCode == 200) {
        var result = response.data['data'];
        ShoppingListDetail shoppingListDetail =
            ShoppingListDetail.fromJson(result);
        return shoppingListDetail;
      }
    } catch (exception) {
      if (exception is DioError) {
        throw exception.error;
      }
      throw exception.toString();
    }
    return null;
  }

  @override
  Future<String> assignMarket(String date, String groupId) async {
    Dio dio = Dio();
    var header = await HttpClient().createHeader();
    var route = ServerAddresses.serverAddress + ServerAddresses.assignMarketer;
    Map<String, dynamic> bodyData = {'date': date, 'groupId': groupId};
    final response = await dio.post(route,
        data: bodyData, options: Options(headers: header));
    return response.statusCode.toString();
  }

  @override
  Future<String> unAssignMarket(String date, String groupId) async {
    Dio dio = Dio();
    var header = await HttpClient().createHeader();
    var route =
        ServerAddresses.serverAddress + ServerAddresses.unassignMarketer;
    Map<String, dynamic> bodyData = {'date': date, 'groupId': groupId};
    final response = await dio.post(route,
        data: bodyData, options: Options(headers: header));
    return response.statusCode.toString();
  }

  @override
  Future<List<ShoppingListModel>> getGroupShoppingList() async {
    try {
      Dio dio = Dio();
      String route = ServerAddresses.serverAddress +
          ServerAddresses.getShoppingListByGroup;
      var header = await HttpClient().createHeader();
      final response = await dio.get(route, options: Options(headers: header));
      List<ShoppingListModel> shoppingListItemList = [];
      if (response.statusCode == 200) {
        var result = response.data['data'] as List;
        for (var element in result) {
          ShoppingListModel model = ShoppingListModel.fromJson(element);
          shoppingListItemList.add(model);
        }
      }
      return shoppingListItemList;
    } on DioError catch (exception) {
      throw Exception(exception.message);
    }
  }

  @override
  Future<List<ShoppingListModel>> getShoppingList() async {
    try {
      Dio dio = Dio();
      String route =
          ServerAddresses.serverAddress + ServerAddresses.getShoppingListByUser;
      var header = await HttpClient().createHeader();
      final response = await dio.get(route, options: Options(headers: header));
      List<ShoppingListModel> shoppingListItemList = [];
      if (response.statusCode == 200) {
        var result = response.data['data'] as List;
        for (var element in result) {
          ShoppingListModel model = ShoppingListModel.fromJson(element);
          shoppingListItemList.add(model);
        }
      }
      return shoppingListItemList;
    } on DioError catch (exception) {
      throw Exception(exception.message);
    }
  }
}
