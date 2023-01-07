import 'package:plan_meal_app/data/model/ingredient.dart';
import 'package:plan_meal_app/data/model/location.dart';

abstract class IngredientRepository {
  Future<List<Ingredient>> searchIngredient(String keyword, int page);
  Future<List<Location>> searchLocation(String keyword, int page);
  Future<String> addLocation(String location);
}