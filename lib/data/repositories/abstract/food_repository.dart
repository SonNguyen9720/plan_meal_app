import 'package:plan_meal_app/data/model/food.dart';

abstract class FoodRepository {
  Future<List<Food>> searchFoodList(String keyword);
  Future<String> addMealFood(String dishId, String date, String meal,
      {int quantity = 1});
  Future<Food> getFood(String dishId);
}
