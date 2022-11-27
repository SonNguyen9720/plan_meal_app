import 'package:equatable/equatable.dart';

class IngredientDetailEntity extends Equatable {
  final String ingredientId;
  final String name;
  final int calories;
  final int quantity;
  final int weight;
  final String measurementType;
  final String type;
  final String imageUrl;

  const IngredientDetailEntity(
      {required this.ingredientId,
      required this.name,
      required this.calories,
      this.quantity = 1,
      this.weight = 1,
      this.measurementType = "GRAMME",
      this.type = "individual",
      required this.imageUrl});

  @override
  List<Object?> get props =>
      [ingredientId, name, quantity, weight, measurementType, type, imageUrl];
}
