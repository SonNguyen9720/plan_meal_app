import 'package:plan_meal_app/data/model/ingredient_by_day.dart';
import 'package:plan_meal_app/data/model/shopping_list.dart';
import 'package:plan_meal_app/data/model/shopping_list_detail.dart';

abstract class ShoppingListRepository {
  Future<String> addIngredient(String ingredientId, String date, int quantity,
      String measurementTypeId, String location, String note);
  Future<List<IngredientByDay>> getIngredient(String date);
  Future<String> removeIngredient(String id, String date);
  Future<String> checkIngredient(String id);
  Future<String> uncheckIngredient(String id);
  Future<String> updateIngredient(String id, int quantity, String measurementTypeId);
  Future<List<IngredientByDay>> getGroupIngredient(String groupId, String date);
  Future<String> addGroupIngredient(String groupId, String id, String name, int quantity,
      String measurementTypeId, String type, String date);
  Future<ShoppingListDetail?> getShoppingListDetail(String date, String groupId);
  Future<String> assignMarket(String date, String groupId);
  Future<String> unAssignMarket(String date, String groupId);
  Future<List<ShoppingListModel>> getGroupShoppingList();
  Future<List<ShoppingListModel>> getShoppingList();
}
