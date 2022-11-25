import 'package:equatable/equatable.dart';

class FoodMealEntity extends Equatable {
  final int foodToMenuId;
  final int foodId;
  final String name;
  final String calories;
  final String meal;
  final String image;
  final bool tracked;

  const FoodMealEntity(
      {required this.foodToMenuId,
        required this.foodId,
      required this.name,
      required this.calories,
      required this.meal,
      required this.image,
      required this.tracked});

  @override
  List<Object?> get props => [foodId, name, calories, meal, calories, tracked];
}
