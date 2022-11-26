import 'package:plan_meal_app/data/model/ingredient.dart';
import 'package:plan_meal_app/data/repositories/abstract/ingredient_repository.dart';

class IngredientRepositoryImpl extends IngredientRepository {
  IngredientRepository ingredientRepository;

  IngredientRepositoryImpl({required this.ingredientRepository});

  @override
  Future<List<Ingredient>> searchIngredient(String keyword) {
    return ingredientRepository.searchIngredient(keyword);
  }
}