import 'package:equatable/equatable.dart';

class FoodMealEntity extends Equatable {
  final String name;
  final String calories;
  final String meal;
  final String image;

  const FoodMealEntity({required this.name, required this.calories, required this.meal, required this.image});

  @override
  List<Object?> get props => [];

}