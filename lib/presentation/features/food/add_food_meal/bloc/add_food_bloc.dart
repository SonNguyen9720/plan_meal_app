import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/food_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/food_search_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_food_event.dart';

part 'add_food_state.dart';

class AddFoodBloc extends Bloc<AddFoodEvent, AddFoodState> {
  final FoodRepository foodRepository;

  AddFoodBloc({required this.foodRepository}) : super(AddFoodInitial()) {
    on<AddFoodLoadFood>(_onAddFoodLoadFood);
    on<AddFoodAddingFood>(_onAddFoodAddingFood);
    on<AddFoodRemovingFood>(_onAddFoodRemovingFood);
    on<AddFoodSendFood>(_onAddFoodSendFood);
    on<AddFoodUpdateFood>(_onAddFoodUpdateFood);
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

  Future<void> _onAddFoodSendFood(
      AddFoodSendFood event, Emitter<AddFoodState> emit) async {
    if (state is AddFoodHasFood) {
      emit(AddFoodLoadingFood());
      var prefs = await SharedPreferences.getInstance();
      var date = DateTimeUtils.parseDateTime(event.date);
      for (var food in event.foodSearchEntityList) {
        if (food.type == "group") {
          String groupId = prefs.getString("groupId") ?? "";
          String result = await foodRepository.addMealFoodGroup(
              groupId, food.id, food.type, date, event.meal,
              quantity: food.quantity);
          if (result != "201") {
            break;
          }
        } else {
          String result = await foodRepository.addMealFood(food.id, food.type, date, event.meal,
              quantity: food.quantity);
          if (result != "201") {
            break;
          }
        }
      }
    }
    emit(AddFoodComplete());
  }

  void _onAddFoodUpdateFood(
      AddFoodUpdateFood event, Emitter<AddFoodState> emit) {
    if (state is AddFoodHasFood) {
      List<FoodSearchEntity> foodSearchEntityList = [];
      foodSearchEntityList.addAll(event.foodSearchEntityList);
      foodSearchEntityList[event.index] = FoodSearchEntity(
          id: foodSearchEntityList[event.index].id,
          name: foodSearchEntityList[event.index].name,
          calories: foodSearchEntityList[event.index].calories,
          quantity: event.quantity,
          fat: foodSearchEntityList[event.index].fat,
          carb: foodSearchEntityList[event.index].carb,
          protein: foodSearchEntityList[event.index].protein,
          type: event.type);
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
