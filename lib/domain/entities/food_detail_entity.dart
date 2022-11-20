import 'package:equatable/equatable.dart';

class FoodDetailEntity extends Equatable {
  final String foodId;
  final String name;
  final String calories;
  final String fat;
  final String protein;
  final String carb;
  final String imageUrl;

  const FoodDetailEntity(
      {required this.foodId,
      required this.name,
      required this.calories,
      required this.fat,
      required this.protein,
      required this.carb,
      required this.imageUrl});

  @override
  List<Object?> get props =>
      [foodId, name, calories, fat, protein, carb, imageUrl];
}
