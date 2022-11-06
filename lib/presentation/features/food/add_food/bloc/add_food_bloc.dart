import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/food_repository.dart';

part 'add_food_event.dart';
part 'add_food_state.dart';

class AddFoodBloc extends Bloc<AddFoodEvent, AddFoodState> {
  final FoodRepository foodRepository;
  AddFoodBloc({required this.foodRepository}) : super(AddFoodInitial()) {
    on<AddFoodLoadFood>(_onAddFoodLoadFood);
  }

  void _onAddFoodLoadFood(AddFoodLoadFood event, Emitter<AddFoodState> emit) {
    emit(AddFoodLoading());
    emit(AddFoodNoFood());
  }
}
