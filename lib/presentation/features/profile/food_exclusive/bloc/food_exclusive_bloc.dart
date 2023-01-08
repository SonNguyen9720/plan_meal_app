import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'food_exclusive_event.dart';

part 'food_exclusive_state.dart';

class FoodExclusiveBloc extends Bloc<FoodExclusiveEvent, FoodExclusiveState> {
  FoodExclusiveBloc() : super(FoodExclusiveInitial()) {
    on<FoodExclusiveGetIngredient>((event, emit) {
      // TODO: implement event handler
    });
  }

  void onFoodExclusiveGetIngredient(
      FoodExclusiveGetIngredient event, Emitter<FoodExclusiveState> emit) {

  }
}
