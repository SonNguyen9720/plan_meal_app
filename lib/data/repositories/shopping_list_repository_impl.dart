import 'package:plan_meal_app/data/model/ingredient_by_day.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/shopping_list_repository_remote.dart';

class ShoppingListRepositoryImpl extends ShoppingListRepository {
  ShoppingListRepositoryRemote shoppingListRepositoryRemote;

  ShoppingListRepositoryImpl({required this.shoppingListRepositoryRemote});

  @override
  Future<String> addIngredient(String id, String name, int quantity, int weight, String measurementType, String type, String date) {
    return shoppingListRepositoryRemote.addIngredient(id, name, quantity, weight, measurementType, type, date);
  }

  @override
  Future<List<IngredientByDay>> getIngredient(String date) {
    return shoppingListRepositoryRemote.getIngredient(date);
  }

  @override
  Future<String> removeIngredient(String id, String date) {
    return shoppingListRepositoryRemote.removeIngredient(id, date);
  }


}