import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/food_repository.dart';

part 'create_food_event.dart';
part 'create_food_state.dart';

class CreateFoodBloc extends Bloc<CreateFoodEvent, CreateFoodState> {

  final FoodRepository foodRepository;

  CreateFoodBloc({required this.foodRepository}) : super(CreateFoodInitial()) {
    on<CreateFoodAddFood>(onCreateFoodEvent);
  }
  Future<void> onCreateFoodEvent(CreateFoodAddFood event, Emitter<CreateFoodState> emit) async {
    emit(CreateFoodLoading());
    var result = await foodRepository.addFood(event.name, event.carb, event.fat, event.protein, event.calories, event.imageUrl, "");
    if (result == "201") {
      emit(CreateFoodFinished());
    } else {
      emit(CreateFoodInitial());
    }
  }
}
