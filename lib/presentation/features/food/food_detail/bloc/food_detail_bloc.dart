import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/food_repository.dart';
part 'food_detail_event.dart';
part 'food_detail_state.dart';

class FoodDetailBloc extends Bloc<FoodDetailEvent, FoodDetailState> {
  final FoodRepository foodRepository;

  FoodDetailBloc({required this.foodRepository}) : super(FoodDetailInitial()) {
    on<FoodDetailLoadEvent>(_onFoodDetailLoadEvent);
  }
  void _onFoodDetailLoadEvent(FoodDetailLoadEvent event, Emitter<FoodDetailState> emit) {
    emit(FoodDetailLoading());
    var food = foodRepository.getFood(event.foodId);
    emit(FoodDetailLoaded());
  }

}
