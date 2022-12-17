import 'package:plan_meal_app/data/model/ingredient_by_day.dart';
import 'package:plan_meal_app/data/model/shopping_list_detail.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/shopping_list_repository_remote.dart';

class ShoppingListRepositoryImpl extends ShoppingListRepository {
  ShoppingListRepositoryRemote shoppingListRepositoryRemote;

  ShoppingListRepositoryImpl({required this.shoppingListRepositoryRemote});

  @override
  Future<String> addIngredient(String id, String name, int quantity, String measurementTypeId, String type, String date) {
    return shoppingListRepositoryRemote.addIngredient(id, name, quantity, measurementTypeId, type, date);
  }

  @override
  Future<List<IngredientByDay>> getIngredient(String date) {
    return shoppingListRepositoryRemote.getIngredient(date);
  }

  @override
  Future<String> removeIngredient(String id, String date) {
    return shoppingListRepositoryRemote.removeIngredient(id, date);
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
  Future<String> updateIngredient(String id, int quantity, String measurementType) {
    return shoppingListRepositoryRemote.updateIngredient(id, quantity, measurementType);
  }

  @override
  Future<List<IngredientByDay>> getGroupIngredient(String groupId, String date) {
    return shoppingListRepositoryRemote.getGroupIngredient(groupId, date);
  }

  @override
  Future<String> addGroupIngredient(String groupId, String id, String name, int quantity, String measurementTypeId, String type, String date) {
    return shoppingListRepositoryRemote.addGroupIngredient(groupId ,id, name, quantity, measurementTypeId, type, date);
  }

  @override
  Future<ShoppingListDetail?> getShoppingListDetail(String date, String groupId) {
    return shoppingListRepositoryRemote.getShoppingListDetail(date, groupId);
  }

  @override
  Future<String> assignMarket(String date, String groupId) {
    return shoppingListRepositoryRemote.assignMarket(date, groupId);
  }

  @override
  Future<String> unAssignMarket(String date, String groupId) {
    return shoppingListRepositoryRemote.assignMarket(date, groupId);
  }
}