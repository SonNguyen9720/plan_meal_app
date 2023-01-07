import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/ingredient_detail_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'ingredient_event.dart';

part 'ingredient_state.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final ShoppingListRepository shoppingListRepository;

  IngredientBloc({required this.shoppingListRepository})
      : super(const IngredientInitial()) {
    on<IngredientAddIngredientEvent>(onIngredientAddIngredientEvent);
    on<IngredientSendIngredientEvent>(onIngredientSendIngredientEvent);
    on<IngredientRemoveIngredientEvent>(onIngredientRemoveIngredientEvent);
    on<IngredientUpdateIngredientEvent>(onIngredientUpdateIngredientEvent);
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
    var prefs = await SharedPreferences.getInstance();
    List<IngredientDetailEntity> listIngredient = [];
    listIngredient.addAll(event.ingredientDetailEntityList);
    String date = DateTimeUtils.parseDateTime(event.date);
    for (var ingredient in listIngredient) {
      String result = "";
      if (ingredient.type == "individual") {
        result = await shoppingListRepository.addIngredient(
            ingredient.ingredientId,
            date,
            ingredient.quantity,
            ingredient.measurementType.id,
            ingredient.location.id,
            ingredient.note);
      } else {
        String groupId = prefs.getString("groupId") ?? "";
        result = await shoppingListRepository.addGroupIngredient(
            groupId,
            ingredient.ingredientId,
            date,
            ingredient.quantity,
            ingredient.measurementType.id,
            ingredient.location.id,
            ingredient.note);
      }
      if (result != "201") {
        break;
      }
    }
    emit(IngredientFinished());
  }

  void onIngredientRemoveIngredientEvent(
      IngredientRemoveIngredientEvent event, Emitter<IngredientState> emit) {
    List<IngredientDetailEntity> ingredientList = [];
    ingredientList.addAll(event.ingredientDetailEntityList);
    ingredientList.remove(event.ingredientDetailEntity);
    emit(IngredientInitial(listIngredientDetailEntity: ingredientList));
  }

  void onIngredientUpdateIngredientEvent(
      IngredientUpdateIngredientEvent event, Emitter<IngredientState> emit) {
    List<IngredientDetailEntity> ingredientList = [];
    ingredientList.addAll(event.ingredientDetailEntityList);
    ingredientList[event.index] = event.ingredientDetailEntity;
    emit(IngredientInitial(listIngredientDetailEntity: ingredientList));
  }
}
