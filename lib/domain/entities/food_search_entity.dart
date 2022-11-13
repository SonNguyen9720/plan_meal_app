import 'package:equatable/equatable.dart';

class FoodSearchEntity extends Equatable {
  final String id;
  final String name;
  final int calories;
  final int quantity;

  const FoodSearchEntity(
      {required this.id,
      required this.name,
      required this.calories,
      required this.quantity});

  @override
  List<Object?> get props => [];
}
