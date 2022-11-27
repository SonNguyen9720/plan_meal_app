import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/ingredient_detail_entity.dart';

part 'ingredient_event.dart';

part 'ingredient_state.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final ShoppingListRepository shoppingListRepository;

  IngredientBloc({required this.shoppingListRepository})
      : super(const IngredientInitial()) {
    on<IngredientAddIngredientEvent>(onIngredientAddIngredientEvent);
    on<IngredientSendIngredientEvent>(onIngredientSendIngredientEvent);
  }

  void onIngredientAddIngredientEvent(
      IngredientAddIngredientEvent event, Emitter<IngredientState> emit) {
    List<IngredientDetailEntity> ingredientList = [];
    ingredientList.addAll(event.ingredientDetailEntityList);
    ingredientList.add(event.ingredientDetailEntity);
    emit(IngredientInitial(listIngredientDetailEntity: ingredientList));
  }

  Future<void> onIngredientSendIngredientEvent(
      IngredientSendIngredientEvent event,
      Emitter<IngredientState> emit) async {
    emit(IngredientLoading());
    List<IngredientDetailEntity> listIngredient = [];
    listIngredient.addAll(event.ingredientDetailEntityList);
    String date = DateTimeUtils.parseDateTime(event.date);
    for (var ingredient in listIngredient) {
      String result = await shoppingListRepository.addIngredient(
          ingredient.ingredientId,
          ingredient.name,
          ingredient.quantity,
          ingredient.weight,
          ingredient.measurementType,
          ingredient.type,
          date);
      if (result != "201") {
        break;
      }
    }
    emit(IngredientFinished());
  }
}
