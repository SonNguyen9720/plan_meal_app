import 'package:equatable/equatable.dart';

class FoodDetailEntity extends Equatable {
  final String foodId;
  final String name;
  final String calories;
  final String fat;
  final String protein;
  final String carb;
  final String imageUrl;
  final String description;
  final String recipe;
  final String cookingTime;
  final String category;
  final List<String> ingredientList;

  const FoodDetailEntity({
    required this.foodId,
    required this.name,
    required this.calories,
    required this.fat,
    required this.protein,
    required this.carb,
    required this.imageUrl,
    required this.description,
    required this.cookingTime,
    required this.recipe,
    required this.category,
    required this.ingredientList,
  });

  @override
  List<Object?> get props => [
        foodId,
        name,
        calories,
        fat,
        protein,
        carb,
        imageUrl,
        description,
        cookingTime,
        recipe,
        category,
        ingredientList,
      ];
}
