import 'package:plan_meal_app/data/model/ingredient.dart';
import 'package:plan_meal_app/data/model/ingredient_by_day.dart';

abstract class ShoppingListRepository {
  Future<String> addIngredient(String id, String name, int quantity, int weight,
      String measurementType, String type, String date);

  Future<List<IngredientByDay>> getIngredient(String date);
}
