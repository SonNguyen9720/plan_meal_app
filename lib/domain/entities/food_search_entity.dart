import 'package:equatable/equatable.dart';

class FoodSearchEntity extends Equatable {
  final String id;
  final String name;
  final int calories;
  final int quantity;
  final String type;
  final int fat;
  final int carb;
  final int protein;

  const FoodSearchEntity({
    required this.id,
    required this.name,
    required this.calories,
    required this.quantity,
    this.type = "individual",
    required this.fat,
    required this.carb,
    required this.protein,
  });

  @override
  List<Object?> get props => [id, name, calories, quantity, type, fat, carb, protein];
}
