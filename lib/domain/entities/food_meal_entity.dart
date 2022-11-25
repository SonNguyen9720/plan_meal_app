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

  const FoodMealEntity(
      {required this.foodToMenuId,
        required this.foodId,
      required this.name,
      required this.calories,
      required this.meal,
      required this.image,
      required this.tracked,
      required this.type,
      required this.quantity});

  @override
  List<Object?> get props => [foodId, name, calories, meal, calories, tracked];
}
