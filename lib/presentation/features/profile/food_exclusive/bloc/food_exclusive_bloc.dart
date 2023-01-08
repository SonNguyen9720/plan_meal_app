import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';

part 'food_exclusive_event.dart';

part 'food_exclusive_state.dart';

class FoodExclusiveBloc extends Bloc<FoodExclusiveEvent, FoodExclusiveState> {
  final UserRepository userRepository;

  FoodExclusiveBloc({required this.userRepository}) : super(FoodExclusiveInitial()) {
    on<FoodExclusiveGetIngredient>((event, emit) {
      // TODO: implement event handler
    });
  }

  void onFoodExclusiveGetIngredient(
      FoodExclusiveGetIngredient event, Emitter<FoodExclusiveState> emit) {

  }
}
