import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/domain/entities/food_exclusive_entity.dart';

part 'food_exclusive_event.dart';

part 'food_exclusive_state.dart';

class FoodExclusiveBloc extends Bloc<FoodExclusiveEvent, FoodExclusiveState> {
  final UserRepository userRepository;

  FoodExclusiveBloc({required this.userRepository}) : super(FoodExclusiveInitial()) {
    on<FoodExclusiveGetIngredient>(onFoodExclusiveGetIngredient);
  }

  Future<void> onFoodExclusiveGetIngredient(
      FoodExclusiveGetIngredient event, Emitter<FoodExclusiveState> emit) async {
    emit(FoodExclusiveLoadingState());
    var listIngredient = await userRepository.getAllergicIngredient();
    List<FoodExclusiveEntity> ingredientEntityList = [];
    for (var element in listIngredient) {
      var ingredient = FoodExclusiveEntity(name: element.ingredient!.name ?? "");
      ingredientEntityList.add(ingredient);
    }
    emit(FoodExclusiveLoadedState(foodExclusiveEntityList: ingredientEntityList));
  }
}
