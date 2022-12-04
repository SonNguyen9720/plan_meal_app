import 'package:equatable/equatable.dart';

class FoodDetectEntity extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final int calories;
  final int carb;
  final int fat;
  final int protein;

  const FoodDetectEntity(
      { required this.id,
        required this.name,
      required this.imageUrl,
      required this.calories,
      this.fat = 0,
      this.carb = 0,
      this.protein = 0});

  @override
  List<Object?> get props => [id, name, imageUrl, calories, fat, carb, protein];
}
