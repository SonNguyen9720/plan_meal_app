import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/menu_repository.dart';
import 'package:intl/intl.dart';
import 'package:plan_meal_app/domain/entities/food_meal_entity.dart';

part 'plan_meal_event.dart';

part 'plan_meal_state.dart';

class PlanMealBloc extends Bloc<PlanMealEvent, PlanMealState> {
  final MenuRepository menuRepository;

  PlanMealBloc({required this.menuRepository}) : super(PlanMealInitial()) {
    on<PlanMealLoadData>(_onPlanMealLoadData);
  }

  Future<void> _onPlanMealLoadData(
      PlanMealLoadData event, Emitter<PlanMealState> emit) async {
    emit(PlanMealLoadingState());
    var outputFormat = DateFormat('dd/MM/yyyy');
    var date = outputFormat.format(event.dateTime);
    var foodMealList = await menuRepository.getMealByDay(date);
    if (foodMealList.isEmpty) {
      emit(PlanMealNoMeal());
    } else {
      List<FoodMealEntity> foodMealListEntity = [];
      for (var element in foodMealList) {
        FoodMealEntity entity = FoodMealEntity(
            meal: element.meal ?? "",
            calories: element.dish?.calories.toString() ?? "",
            name: element.dish?.name ?? "",
            image: element.dish?.imageUrl ?? "");
        foodMealListEntity.add(entity);
      }
      emit(PlanMealHasMeal(foodMealEntity: foodMealListEntity));
    }
  }
}
