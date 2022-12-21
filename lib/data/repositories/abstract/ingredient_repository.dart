import 'package:plan_meal_app/data/model/ingredient.dart';

abstract class IngredientRepository {
  Future<List<Ingredient>> searchIngredient(String keyword, int page);
}