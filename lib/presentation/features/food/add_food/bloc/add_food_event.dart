part of 'add_food_bloc.dart';

abstract class AddFoodEvent extends Equatable {
  const AddFoodEvent();

  @override
  List<Object?> get props => [];
}

class AddFoodLoadFood extends AddFoodEvent {
  final String meal;
  final DateTime date;

  const AddFoodLoadFood({required this.meal, required this.date});
}
