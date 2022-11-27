import 'package:equatable/equatable.dart';

class IngredientEntity extends Equatable {
  final String name;
  final int quantity;
  final String imageUrl;
  final int calories;

  const IngredientEntity(
      {required this.name,
      required this.imageUrl,
      required this.calories,
      this.quantity = 0});

  @override
  List<Object?> get props => [name, quantity, imageUrl];
}
