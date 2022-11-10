import 'package:plan_meal_app/data/model/food.dart';
import 'package:plan_meal_app/data/repositories/abstract/food_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/food_repository_remote.dart';

class FoodRepositoryImpl extends FoodRepository {
  FoodRepositoryRemote foodRepositoryRemote;

  FoodRepositoryImpl({required this.foodRepositoryRemote});
  @override
  Future<List<Food>> searchFoodList(String keyword) {
    return foodRepositoryRemote.searchFoodList(keyword);
  }

  @override
  Future<String> addMealFood(String dishId, String date, String meal, {int quantity = 1}) {
    // TODO: implement addMealFood
    throw UnimplementedError();
  }


}