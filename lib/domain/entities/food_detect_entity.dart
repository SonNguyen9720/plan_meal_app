import 'package:equatable/equatable.dart';

class FoodDetectEntity extends Equatable{
  final String name;
  final String imageUrl;
  final int calories;

  const FoodDetectEntity({required this.name, required this.imageUrl, required this.calories});

  @override
  List<Object?> get props => [name, imageUrl, calories];

}