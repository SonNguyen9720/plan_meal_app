import 'package:plan_meal_app/data/model/food_meal.dart';
import 'package:plan_meal_app/data/repositories/abstract/menu_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/menu_repository_remote.dart';

class MenuRepositoryImpl extends MenuRepository {
  MenuRepositoryRemote menuRepositoryRemote;

  MenuRepositoryImpl({required this.menuRepositoryRemote});
  @override
  Future<List<FoodMeal>> getMealByDay(String date) {
    return menuRepositoryRemote.getMealByDay(date);
  }

  @override
  Future<String> removeFoodFromMenu(String foodId) {
    return menuRepositoryRemote.removeFoodFromMenu(foodId);
  }

  @override
  Future<String> trackFood(String dishToMenuId) {
    return menuRepositoryRemote.trackFood(dishToMenuId);
  }

  @override
  Future<List<FoodMeal>> getMealByGroupByDay(String date, String groupId) {
    return menuRepositoryRemote.getMealByGroupByDay(date, groupId);
  }

  @override
  Future<String> untrackFood(String dishToMenuId) {
    return menuRepositoryRemote.untrackFood(dishToMenuId);
  }

  @override
  Future<String> suggestMeal(String date) {
    return menuRepositoryRemote.suggestMeal(date);
  }
}