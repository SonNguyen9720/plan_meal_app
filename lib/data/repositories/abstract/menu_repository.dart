import 'package:plan_meal_app/data/model/food_meal.dart';

abstract class MenuRepository {
  Future<List<FoodMeal>> getMealByDay(String date);
  Future<String> removeFoodFromMenu(String foodId, String date, String meal);
}