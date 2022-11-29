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
      this.measurementType = "gramme",
      this.type = "individual",
      required this.imageUrl});

  @override
  List<Object?> get props =>
      [ingredientId, name, quantity, weight, measurementType, type, imageUrl];

  IngredientDetailEntity copyWith({
    String? ingredientId,
    String? name,
    int? calories,
    int? quantity,
    int? weight,
    String? measurementType,
    String? type,
    String? imageUrl,
  }) {
    return IngredientDetailEntity(
      ingredientId: ingredientId ?? this.ingredientId,
      name: name ?? this.name,
      calories: calories ?? this.calories,
      quantity: quantity ?? this.quantity,
      weight: weight ?? this.weight,
      measurementType: measurementType ?? this.measurementType,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
