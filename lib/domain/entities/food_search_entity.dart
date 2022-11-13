import 'package:equatable/equatable.dart';

class FoodSearchEntity extends Equatable {
  final String name;
  final String calories;
  final int quantity;

  const FoodSearchEntity({required this.name, required this.calories, required this.quantity});

  @override
  List<Object?> get props => [];

}