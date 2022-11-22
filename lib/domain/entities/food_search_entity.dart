import 'package:equatable/equatable.dart';

class FoodSearchEntity extends Equatable {
  final String id;
  final String name;
  final int calories;
  final int quantity;
  final String type;

  const FoodSearchEntity({
    required this.id,
    required this.name,
    required this.calories,
    required this.quantity,
    this.type = "individual",
  });

  @override
  List<Object?> get props => [id, name, calories, quantity];
}
