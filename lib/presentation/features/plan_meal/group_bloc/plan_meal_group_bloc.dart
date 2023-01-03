import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:plan_meal_app/data/model/food_meal.dart';
import 'package:plan_meal_app/data/network/AppSocket.dart';
import 'package:plan_meal_app/data/repositories/abstract/menu_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/food_meal_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'plan_meal_group_event.dart';

part 'plan_meal_group_state.dart';

class PlanMealGroupBloc extends Bloc<PlanMealGroupEvent, PlanMealGroupState> {
  final MenuRepository menuRepository;
  AppSocket groupSocket = AppSocket();

  PlanMealGroupBloc({required this.menuRepository})
      : super(PlanMealGroupInitial(DateTime.now())) {
    groupSocket.initSocket();
    groupSocket.on("get-group-menu", (data) {
      add(PlanMealGroupLoadedData(data['data']));
    });
    on<PlanMealGroupLoadData>(_onPlanMealGroupLoadData);
    on<PlanMealGroupLoadedData>(_onPlanMealGroupLoadedData);
    on<PlanMealGroupRemoveDishEvent>(_onPlanMealGroupRemoveDishEvent);
    on<PlanMealGroupTrackDishEvent>(_onPlanMealGroupTrackDishEvent);
    on<PlanMealGroupChangeDateEvent>(_onPlanMealGroupChangeDateEvent);
  }

  Future<void> _onPlanMealGroupLoadData(
      PlanMealGroupLoadData event, Emitter<PlanMealGroupState> emit) async {
    emit(PlanMealGroupLoadingState(dateTime: event.dateTime));
    var date = DateTimeUtils.parseDateTime(event.dateTime);
    var prefs = await SharedPreferences.getInstance();
    var groupId = prefs.getString("groupId") ?? "";
    if (groupId.isEmpty) {
      emit(PlanMealGroupNoGroup(dateTime: event.dateTime));
      return;
    }
    Map<String, String> messageMap = {
      'date': date,
      'groupId': groupId,
    };
    groupSocket.emit("get-group-menu", messageMap);
  }

  void _onPlanMealGroupLoadedData(PlanMealGroupLoadedData event, Emitter<PlanMealGroupState> emit) {
    if (kDebugMode) {
      print("${event.data}");
    }
    if (state is PlanMealGroupLoadingState ||
        state is PlanMealGroupNoMeal ||
        state is PlanMealGroupHasMeal) {
      if (event.data.isEmpty) {
        emit(PlanMealGroupNoMeal(dateTime: state.dateTime));
      } else {
        List<FoodMeal> foodMealList = [];
        for (var element in event.data) {
          FoodMeal foodMeal = FoodMeal.fromJson(element);
          foodMealList.add(foodMeal);
        }
        List<FoodMealEntity> foodMealListEntity = [];
        for (var element in foodMealList) {
          FoodMealEntity entity = FoodMealEntity(
            foodToMenuId: element.dishToMenuId ?? 0,
            foodId: element.dish!.id ?? 0,
            meal: element.meal!.name ?? "",
            calories: element.dish?.calories.toString() ?? "",
            name: element.dish?.name ?? "",
            image: element.dish?.imageUrl ?? "",
            tracked: element.tracked ?? false,
            type: element.type ?? "group",
            quantity: element.quantity ?? 0,
            carb: element.dish!.carbohydrates ?? 0,
            protein: element.dish!.protein ?? 0,
            fat: element.dish!.fat ?? 0,
          );
          foodMealListEntity.add(entity);
        }
        emit(PlanMealGroupHasMeal(
            foodMealEntity: foodMealListEntity, dateTime: state.dateTime));
      }
    }
  }

  Future<void> _onPlanMealGroupRemoveDishEvent(
      PlanMealGroupRemoveDishEvent event,
      Emitter<PlanMealGroupState> emit) async {
    var date = DateTimeUtils.parseDateTime(event.dateTime);
    var listFood = List<FoodMealEntity>.from(event.foodMealEntity);
    emit(PlanMealGroupWaitingState(dateTime: event.dateTime));
    var result = await menuRepository.removeFoodFromMenu(event.dishId);
    emit(PlanMealGroupFinishedState(dateTime: event.dateTime));
    if (result == "201") {
      listFood.removeWhere(
          (element) => element.foodToMenuId == int.parse(event.dishId));
      if (listFood.isEmpty) {
        emit(PlanMealGroupNoMeal(dateTime: event.dateTime));
      } else {
        emit(PlanMealGroupHasMeal(
            foodMealEntity: listFood, dateTime: event.dateTime));
      }
    }
  }

  void _onPlanMealGroupTrackDishEvent(PlanMealGroupTrackDishEvent event,
      Emitter<PlanMealGroupState> emit) async {
    // var date = DateTimeUtils.parseDateTime(event.dateTime);
    var listFood = List<FoodMealEntity>.from(event.foodMealEntity);
    emit(PlanMealGroupWaitingState(dateTime: event.dateTime));
    var result = '';
    if (event.tracked) {
      result = await menuRepository.trackFood(event.dishToMenu);
    } else {
      result = await menuRepository.untrackFood(event.dishToMenu);
    }
    emit(PlanMealGroupFinishedState(dateTime: event.dateTime));
    if (result == "201") {
      listFood[event.index] = FoodMealEntity(
        foodToMenuId: listFood[event.index].foodToMenuId,
        foodId: listFood[event.index].foodId,
        name: listFood[event.index].name,
        calories: listFood[event.index].calories,
        meal: listFood[event.index].meal,
        image: listFood[event.index].image,
        tracked: event.tracked,
        type: listFood[event.index].type,
        quantity: listFood[event.index].quantity,
        protein: listFood[event.index].protein,
        fat: listFood[event.index].fat,
        carb: listFood[event.index].carb,
      );
    }
    emit(PlanMealGroupHasMeal(
        foodMealEntity: listFood, dateTime: event.dateTime));
  }

  Future<void> _onPlanMealGroupChangeDateEvent(
      PlanMealGroupChangeDateEvent event,
      Emitter<PlanMealGroupState> emit) async {
    emit(PlanMealGroupLoadingState(dateTime: event.dateTime));
    var date = DateTimeUtils.parseDateTime(event.dateTime);
    var prefs = await SharedPreferences.getInstance();
    var groupId = prefs.getString("groupId") ?? "";
    if (groupId.isEmpty) {
      emit(PlanMealGroupNoGroup(dateTime: event.dateTime));
      return;
    }
    var foodMealList = await menuRepository.getMealByGroupByDay(date, groupId);
    if (foodMealList.isEmpty) {
      emit(PlanMealGroupNoMeal(dateTime: event.dateTime));
    } else {
      List<FoodMealEntity> foodMealListEntity = [];
      for (var element in foodMealList) {
        FoodMealEntity entity = FoodMealEntity(
          foodToMenuId: element.dishToMenuId ?? 0,
          foodId: element.dish!.id ?? 0,
          meal: element.meal!.name ?? "",
          calories: element.dish?.calories.toString() ?? "",
          name: element.dish?.name ?? "",
          image: element.dish?.imageUrl ?? "",
          tracked: element.tracked ?? false,
          type: element.type ?? "group",
          quantity: element.quantity ?? 0,
          carb: element.dish!.carbohydrates ?? 0,
          protein: element.dish!.protein ?? 0,
          fat: element.dish!.fat ?? 0,
        );
        foodMealListEntity.add(entity);
      }
      emit(PlanMealGroupHasMeal(
          foodMealEntity: foodMealListEntity, dateTime: event.dateTime));
    }
  }

  @override
  Future<void> close() {
    AppSocket().disconnectSocket();
    return super.close();
  }
}
