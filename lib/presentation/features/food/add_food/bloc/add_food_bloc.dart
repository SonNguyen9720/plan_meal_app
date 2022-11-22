import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/food_repository.dart';
import 'package:plan_meal_app/domain/entities/food_search_entity.dart';

part 'add_food_event.dart';

part 'add_food_state.dart';

class AddFoodBloc extends Bloc<AddFoodEvent, AddFoodState> {
  final FoodRepository foodRepository;

  AddFoodBloc({required this.foodRepository}) : super(AddFoodInitial()) {
    on<AddFoodLoadFood>(_onAddFoodLoadFood);
    on<AddFoodAddingFood>(_onAddFoodAddingFood);
    on<AddFoodRemovingFood>(_onAddFoodRemovingFood);
  }

  void _onAddFoodLoadFood(AddFoodLoadFood event, Emitter<AddFoodState> emit) {
    emit(AddFoodLoading());
    emit(AddFoodNoFood(date: event.date, meal: event.meal));
  }

  void _onAddFoodAddingFood(
      AddFoodAddingFood event, Emitter<AddFoodState> emit) {
    if (state is AddFoodNoFood) {
      List<FoodSearchEntity> foodSearchEntityList = [];
      foodSearchEntityList.add(event.foodAdd);
      emit(AddFoodHasFood(
          date: event.date,
          meal: event.meal,
          foodSearchEntityList: foodSearchEntityList));
    } else if (state is AddFoodHasFood) {
      List<FoodSearchEntity> foodSearchEntityList = [];
      foodSearchEntityList.addAll(event.foodSearchEntityList);
      foodSearchEntityList.add(event.foodAdd);
      emit(AddFoodHasFood(
          date: event.date,
          meal: event.meal,
          foodSearchEntityList: foodSearchEntityList));
    }
  }

  void _onAddFoodRemovingFood(
      AddFoodRemovingFood event, Emitter<AddFoodState> emit) {
    if (state is AddFoodHasFood) {
      List<FoodSearchEntity> foodSearchEntityList = [];
      foodSearchEntityList.addAll(event.foodSearchEntityList);
      foodSearchEntityList.remove(event.foodRemove);
      if (foodSearchEntityList.isEmpty) {
        emit(AddFoodNoFood(date: event.date, meal: event.meal));
      } else {
        emit(AddFoodHasFood(
            date: event.date,
            meal: event.meal,
            foodSearchEntityList: foodSearchEntityList));
      }
    }
  }
}
