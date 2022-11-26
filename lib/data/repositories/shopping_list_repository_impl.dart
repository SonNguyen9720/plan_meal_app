import 'package:plan_meal_app/data/model/ingredient.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';

class ShoppingListRepositoryImpl extends ShoppingListRepository {
  ShoppingListRepository shoppingListRepository;

  ShoppingListRepositoryImpl({required this.shoppingListRepository});
}