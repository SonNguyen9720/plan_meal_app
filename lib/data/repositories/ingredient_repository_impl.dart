import 'package:plan_meal_app/data/model/ingredient.dart';
import 'package:plan_meal_app/data/model/location.dart';
import 'package:plan_meal_app/data/repositories/abstract/ingredient_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/ingredient_repository_remote.dart';

class IngredientRepositoryImpl extends IngredientRepository {
  IngredientRepositoryRemote ingredientRepositoryRemote;

  IngredientRepositoryImpl({required this.ingredientRepositoryRemote});

  @override
  Future<List<Ingredient>> searchIngredient(String keyword, int page) {
    return ingredientRepositoryRemote.searchIngredient(keyword, page);
  }

  @override
  Future<List<Location>> searchLocation(String keyword, int page) {
    return ingredientRepositoryRemote.searchLocation(keyword, page);
  }

  @override
  Future<String> addLocation(String name, String address) {
    return ingredientRepositoryRemote.addLocation(name, address);
  }
}