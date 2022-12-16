import 'package:plan_meal_app/data/model/food_meal.dart';

abstract class MenuRepository {
  Future<List<FoodMeal>> getMealByDay(String date);
  Future<String> removeFoodFromMenu(String foodId, String date, String meal);
  Future<String> trackFood(String dishToMenuId);
  Future<String> untrackFood(String dishToMenuId);
  Future<List<FoodMeal>> getMealByGroupByDay(String date, String groupId);
  Future<String> suggestMeal(String date);
}