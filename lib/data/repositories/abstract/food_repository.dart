import 'package:plan_meal_app/data/model/food.dart';
import 'package:plan_meal_app/data/model/food_detect.dart';

abstract class FoodRepository {
  Future<List<Food>> searchFoodList(String keyword);

  Future<String> addMealFood(
      String dishId, String type, String date, String meal,
      {int quantity = 1});

  Future<Food> getFood(String dishId);

  Future<List<FoodDetect>> detectFood(String imageUrl);

  Future<String> addFood(String name, int carb, int fat, int protein,
      int calories, String imageUrl, String recipeId);

  Future<String> updateFood(String id, String meal, String type, int quantity);
}
