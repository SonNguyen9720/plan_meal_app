import 'package:equatable/equatable.dart';

class FoodMealEntity extends Equatable {
  final int foodToMenuId;
  final int foodId;
  final String name;
  final String calories;
  final String meal;
  final String image;
  final bool tracked;
  final String type;
  final int quantity;
  final int protein;
  final int fat;
  final int carb;

  const FoodMealEntity(
      {required this.foodToMenuId,
        required this.foodId,
      required this.name,
      required this.calories,
      required this.meal,
      required this.image,
      required this.tracked,
      required this.type,
      required this.quantity,
        required this.protein,
        required this.fat,
        required this.carb
      });

  @override
  List<Object?> get props => [foodId, name, calories, meal, calories, tracked];
}
