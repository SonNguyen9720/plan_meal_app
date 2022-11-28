import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/ingredient_by_day.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/ingredient_by_day_entity.dart';

part 'individual_event.dart';

part 'individual_state.dart';

class IndividualBloc extends Bloc<IndividualEvent, IndividualState> {
  final ShoppingListRepository shoppingListRepository;

  IndividualBloc({required this.shoppingListRepository})
      : super(IndividualInitial()) {
    on<IndividualLoadingDataEvent>(_onIndividualLoadingDataEvent);
    on<IndividualChangeDateEvent>(_onIndividualChangeDateEvent);
  }

  Future<void> _onIndividualLoadingDataEvent(IndividualLoadingDataEvent event,
      Emitter<IndividualState> emit) async {
    emit(IndividualLoadingItem(dateTime: event.dateTime));
    String date = DateTimeUtils.parseDateTime(event.dateTime);
    List<IngredientByDay> listIngredient = await shoppingListRepository
        .getIngredient(date);
    List<IngredientByDayEntity> listIngredientEntity = [];
    for (var ingredient in listIngredient) {
      var ingredientEntity = IngredientByDayEntity(
          name: ingredient.ingredient?.name ?? "",
          imageUrl: ingredient.ingredient?.imageUrl ?? "",
          quantity: ingredient.quantity ?? 0,
          measurement: ingredient.measurementType ?? "GRAMME",
          checked: ingredient.checked ?? false,
          type: "individual");
      listIngredientEntity.add(ingredientEntity);
    }
    if (listIngredientEntity.isEmpty) {
      emit(IndividualNoItem(dateTime: event.dateTime));
    } else {
      emit(IndividualHasItem(dateTime: event.dateTime, listIngredient: listIngredientEntity));
    }
  }

  Future<void> _onIndividualChangeDateEvent(IndividualChangeDateEvent event,
      Emitter<IndividualState> emit) async {
    var date = event.dateTime;

    emit(IndividualLoadingItem(dateTime: date));
    await Future.delayed(const Duration(seconds: 2));
    emit(IndividualNoItem(dateTime: date));
  }
}
