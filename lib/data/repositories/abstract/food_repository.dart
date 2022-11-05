import 'package:plan_meal_app/data/model/food.dart';

abstract class FoodRepository {
  Future<List<Food>> searchFoodList(String keyword);
}