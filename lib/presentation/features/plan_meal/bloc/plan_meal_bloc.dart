import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/config/global_variable.dart';
import 'package:plan_meal_app/data/model/food_meal.dart';
import 'package:plan_meal_app/data/model/group_member.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/menu_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/food_meal_entity.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'plan_meal_event.dart';

part 'plan_meal_state.dart';

class PlanMealBloc extends Bloc<PlanMealEvent, PlanMealState> {
  final MenuRepository menuRepository;
  final GroupRepository groupRepository;

  PlanMealBloc({required this.menuRepository, required this.groupRepository})
      : super(PlanMealInitial(DateTime.now())) {
    on<PlanMealLoadData>(_onPlanMealLoadData);
    on<PlanMealRemoveDishEvent>(_onPlanMealRemoveDishEvent);
    on<PlanMealTrackDishEvent>(_onPlanMealTrackDishEvent);
    on<PlanMealChangeDateEvent>(_onPlanMealChangeDateEvent);
    on<PlanMealSuggestFoodEvent>(_onPlanMealSuggestFoodEvent);
  }

  Future<void> _onPlanMealLoadData(
      PlanMealLoadData event, Emitter<PlanMealState> emit) async {
    emit(PlanMealLoadingState(dateTime: event.dateTime));
    var date = DateTimeUtils.parseDateTime(event.dateTime);
    var prefs = await SharedPreferences.getInstance();
    var groupId = prefs.getString("groupId") ?? "";
    int member = 1;
    List<FoodMeal> foodGroupMealList = [];
    if (groupId.isNotEmpty) {
      List<GroupMember> listMember = await groupRepository
          .getMemberListByGroupId(groupId: int.parse(groupId));
      member = listMember.length;
      foodGroupMealList =
          await menuRepository.getMealByGroupByDay(date, groupId);
    }
    var foodMealList = await menuRepository.getMealByDay(date);
    if (foodMealList.isEmpty && foodGroupMealList.isEmpty) {
      emit(PlanMealNoMeal(dateTime: event.dateTime));
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
          type: element.type ?? "individual",
          quantity: element.quantity ?? 0,
          carb: element.dish!.carbohydrates ?? 0,
          protein: element.dish!.protein ?? 0,
          fat: element.dish!.fat ?? 0,
        );
        foodMealListEntity.add(entity);
      }
      for (var element in foodGroupMealList) {
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
      emit(PlanMealHasMeal(
          foodMealEntity: foodMealListEntity,
          dateTime: event.dateTime,
          member: member));
    }
  }

  Future<void> _onPlanMealRemoveDishEvent(
      PlanMealRemoveDishEvent event, Emitter<PlanMealState> emit) async {
    var date = DateTimeUtils.parseDateTime(event.dateTime);
    emit(PlanMealWaiting(dateTime: event.dateTime));
    var listFood = List<FoodMealEntity>.from(event.foodMealEntity);
    var result =
        await menuRepository.removeFoodFromMenu(event.dishId, date, event.meal);
    emit(PlanMealFinished(dateTime: event.dateTime));
    if (result == "201") {
      listFood.removeWhere(
          (element) => element.foodToMenuId == int.parse(event.dishId));
      if (listFood.isEmpty) {
        emit(PlanMealNoMeal(dateTime: event.dateTime));
      } else {
        emit(PlanMealHasMeal(
            foodMealEntity: listFood,
            dateTime: event.dateTime,
            member: event.member));
      }
    }
  }

  void _onPlanMealTrackDishEvent(
      PlanMealTrackDishEvent event, Emitter<PlanMealState> emit) async {
    emit(PlanMealWaiting(dateTime: event.dateTime));
    var listFood = List<FoodMealEntity>.from(event.foodMealEntity);
    var result = "";
    if (event.tracked) {
      result = await menuRepository.trackFood(event.dishToMenu);
    } else {
      result = await menuRepository.untrackFood(event.dishToMenu);
    }
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
    emit(PlanMealFinished(dateTime: event.dateTime));
    emit(PlanMealHasMeal(
        foodMealEntity: listFood,
        dateTime: event.dateTime,
        member: event.member));
  }

  Future<void> _onPlanMealChangeDateEvent(
      PlanMealChangeDateEvent event, Emitter<PlanMealState> emit) async {
    emit(PlanMealLoadingState(dateTime: event.dateTime));
    var date = DateTimeUtils.parseDateTime(event.dateTime);
    var prefs = await SharedPreferences.getInstance();
    var groupId = prefs.getString("groupId") ?? "";
    int member = 1;
    if (groupId.isNotEmpty) {
      List<GroupMember> listMember = await groupRepository
          .getMemberListByGroupId(groupId: int.parse(groupId));
      member = listMember.length;
    }
    var foodMealList = await menuRepository.getMealByDay(date);
    var foodGroupMealList =
        await menuRepository.getMealByGroupByDay(date, groupId);
    if (foodMealList.isEmpty && foodGroupMealList.isEmpty) {
      emit(PlanMealNoMeal(dateTime: event.dateTime));
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
          type: element.type ?? "individual",
          quantity: element.quantity ?? 0,
          carb: element.dish!.carbohydrates ?? 0,
          protein: element.dish!.protein ?? 0,
          fat: element.dish!.fat ?? 0,
        );
        foodMealListEntity.add(entity);
      }
      for (var element in foodGroupMealList) {
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
      emit(PlanMealHasMeal(
          foodMealEntity: foodMealListEntity,
          dateTime: event.dateTime,
          member: member));
    }
  }

  Future<void> _onPlanMealSuggestFoodEvent(
      PlanMealSuggestFoodEvent event, Emitter<PlanMealState> emit) async {
    try {
      emit(PlanMealLoadingState(dateTime: event.dateTime));
      String dateTime = DateTimeUtils.parseDateTime(event.dateTime);
      String statusCode = await menuRepository.suggestMeal(dateTime);
      if (statusCode == "201") {
        var foodMealList = await menuRepository.getMealByDay(dateTime);
        var groupId = PreferenceUtils.getString(GlobalVariable.groupId) ?? "";
        int member = 1;
        if (groupId.isNotEmpty) {
          List<GroupMember> listMember = await groupRepository
              .getMemberListByGroupId(groupId: int.parse(groupId));
          member = listMember.length;
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
            type: element.type ?? "individual",
            quantity: element.quantity ?? 0,
            carb: element.dish!.carbohydrates ?? 0,
            protein: element.dish!.protein ?? 0,
            fat: element.dish!.fat ?? 0,
          );
          foodMealListEntity.add(entity);
        }
        emit(PlanMealHasMeal(
            foodMealEntity: foodMealListEntity,
            dateTime: event.dateTime,
            member: member));
      }
    } catch (exception) {
      emit(PlanMealError(
          errorMessage: exception.toString(), dateTime: event.dateTime));
    }
  }
}
