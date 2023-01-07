import 'package:plan_meal_app/data/model/ingredient_by_day.dart';
import 'package:plan_meal_app/data/model/shopping_list.dart';
import 'package:plan_meal_app/data/model/shopping_list_detail.dart';

abstract class ShoppingListRepository {
  Future<String> addIngredient(String ingredientId, String date, int quantity,
      String measurementTypeId, String locationId, String note);

  Future<List<IngredientByDay>> getIngredient(String dateStart, String dateEnd);

  Future<String> removeIngredient(String id);

  Future<String> checkIngredient(String id);

  Future<String> uncheckIngredient(String id);

  Future<String> updateIngredient(
      String id, int quantity, String measurementTypeId, String locationId, String note);

  Future<List<IngredientByDay>> getGroupIngredient(String groupId, String dateStart, String dateEnd);

  Future<String> addGroupIngredient(
      String groupId,
      String ingredientId,
      String date,
      int quantity,
      String measurementTypeId,
      String locationId,
      String note);

  Future<ShoppingListDetail?> getShoppingListDetail(
      String date, String groupId);

  Future<String> assignMarket(String date, String groupId);

  Future<String> unAssignMarket(String date, String groupId);

  Future<List<ShoppingListModel>> getGroupShoppingList();

  Future<List<ShoppingListModel>> getShoppingList();
}
