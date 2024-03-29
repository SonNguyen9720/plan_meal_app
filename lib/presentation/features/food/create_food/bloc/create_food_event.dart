part of 'create_food_bloc.dart';

abstract class CreateFoodEvent extends Equatable {
  const CreateFoodEvent();
}

class CreateFoodAddFood extends CreateFoodEvent {
  final String name;
  final int carb;
  final int fat;
  final int protein;
  final int calories;
  final String imageUrl;

  const CreateFoodAddFood({
    required this.name,
    required this.carb,
    required this.fat,
    required this.protein,
    required this.calories,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name, carb, fat, protein, calories, imageUrl];
}
