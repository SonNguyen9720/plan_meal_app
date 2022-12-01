import 'package:plan_meal_app/data/model/ingredient_by_day.dart';

abstract class ShoppingListRepository {
  Future<String> addIngredient(String id, String name, int quantity, int weight,
      String measurementType, String type, String date);

  Future<List<IngredientByDay>> getIngredient(String date);
  Future<String> removeIngredient(String id, String date);
  Future<String> checkIngredient(String id);
  Future<String> uncheckIngredient(String id);
  Future<String> updateIngredient(String id, int quantity, int weight, String measurementType);
  Future<List<IngredientByDay>> getGroupIngredient(String groupId, String date);
}
