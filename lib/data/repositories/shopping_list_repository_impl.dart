import 'package:plan_meal_app/data/model/ingredient_by_day.dart';
import 'package:plan_meal_app/data/model/shopping_list.dart';
import 'package:plan_meal_app/data/model/shopping_list_detail.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/shopping_list_repository_remote.dart';

class ShoppingListRepositoryImpl extends ShoppingListRepository {
  ShoppingListRepositoryRemote shoppingListRepositoryRemote;

  ShoppingListRepositoryImpl({required this.shoppingListRepositoryRemote});

  @override
  Future<String> addIngredient(String ingredientId, String date, int quantity,
      String measurementTypeId, String locationId, String note) {
    return shoppingListRepositoryRemote.addIngredient(
        ingredientId, date, quantity, measurementTypeId, locationId, note);
  }

  @override
  Future<List<IngredientByDay>> getIngredient(String dateStart, String dateEnd) {
    return shoppingListRepositoryRemote.getIngredient(dateStart, dateEnd);
  }

  @override
  Future<String> removeIngredient(String id) {
    return shoppingListRepositoryRemote.removeIngredient(id);
  }

  @override
  Future<String> checkIngredient(String id) {
    return shoppingListRepositoryRemote.checkIngredient(id);
  }

  @override
  Future<String> uncheckIngredient(String id) {
    return shoppingListRepositoryRemote.uncheckIngredient(id);
  }

  @override
  Future<String> updateIngredient(
      String id, int quantity, String measurementTypeId) {
    return shoppingListRepositoryRemote.updateIngredient(
        id, quantity, measurementTypeId);
  }

  @override
  Future<List<IngredientByDay>> getGroupIngredient(
      String groupId, String dateStart, String dateEnd) {
    return shoppingListRepositoryRemote.getGroupIngredient(groupId, dateStart, dateEnd);
  }

  @override
  Future<String> addGroupIngredient(
      String groupId,
      String ingredientId,
      String date,
      int quantity,
      String measurementTypeId,
      String location,
      String note) {
    return shoppingListRepositoryRemote.addGroupIngredient(groupId,
        ingredientId, date, quantity, measurementTypeId, location, note);
  }

  @override
  Future<ShoppingListDetail?> getShoppingListDetail(
      String date, String groupId) {
    return shoppingListRepositoryRemote.getShoppingListDetail(date, groupId);
  }

  @override
  Future<String> assignMarket(String date, String groupId) {
    return shoppingListRepositoryRemote.assignMarket(date, groupId);
  }

  @override
  Future<String> unAssignMarket(String date, String groupId) {
    return shoppingListRepositoryRemote.unAssignMarket(date, groupId);
  }

  @override
  Future<List<ShoppingListModel>> getGroupShoppingList() {
    return shoppingListRepositoryRemote.getGroupShoppingList();
  }

  @override
  Future<List<ShoppingListModel>> getShoppingList() {
    return shoppingListRepositoryRemote.getShoppingList();
  }
}
