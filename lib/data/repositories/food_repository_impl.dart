import 'package:plan_meal_app/data/model/food.dart';
import 'package:plan_meal_app/data/model/food_detect.dart';
import 'package:plan_meal_app/data/model/incompatable_ingredient.dart';
import 'package:plan_meal_app/data/model/ingredient_of_food.dart';
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
  Future<String> addMealFood(
      String dishId,
      String type,
      String date,
      String mealId,
      String dishType,
      String individualShoppingListId,
      String note,
      {int quantity = 1}) {
    return foodRepositoryRemote.addMealFood(
        dishId, type, date, mealId, dishType, individualShoppingListId, note);
  }

  @override
  Future<Food> getFood(String dishId) {
    return foodRepositoryRemote.getFood(dishId);
  }

  @override
  Future<List<FoodDetect>> detectFood(String imageUrl) {
    return foodRepositoryRemote.detectFood(imageUrl);
  }

  @override
  Future<String> addFood(String name, int carb, int fat, int protein,
      int calories, String imageUrl, String recipeId) {
    return foodRepositoryRemote.addFood(
        name, carb, fat, protein, calories, imageUrl, recipeId);
  }

  @override
  Future<String> updateFood(String id, String mealId, int quantity, String dishType, String note) {
    return foodRepositoryRemote.updateFood(id, mealId, quantity, dishType, note);
  }

  @override
  Future<String> addMealFoodGroup(
      String groupId, String dishId, String type, String date, String mealId,
      {int quantity = 1}) {
    return foodRepositoryRemote.addMealFoodGroup(
        groupId, dishId, type, date, mealId,
        quantity: quantity);
  }

  @override
  Future<List<IngredientOfFood>> getIngredientByFood(String dishId) {
    return foodRepositoryRemote.getIngredientByFood(dishId);
  }

  @override
  Future<List<IncompatibleIngredient>> getIncompatibleIngredient(String ingredientId) {
    return foodRepositoryRemote.getIncompatibleIngredient(ingredientId);
  }
}
