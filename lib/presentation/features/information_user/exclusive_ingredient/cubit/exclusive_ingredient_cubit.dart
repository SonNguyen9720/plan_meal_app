import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/domain/entities/exclusive_ingredient_entity.dart';

part 'exclusive_ingredient_state.dart';

class ExclusiveIngredientCubit extends Cubit<ExclusiveIngredientState> {
  ExclusiveIngredientCubit() : super(const ExclusiveIngredientInitial());

  void onAddIngredientList(ExclusiveIngredientEntity ingredientEntity,
      List<ExclusiveIngredientEntity> ingredientList) {
    List<ExclusiveIngredientEntity> newIngredientList = [];
    newIngredientList.addAll(ingredientList);
    newIngredientList.add(ingredientEntity);
    emit(ExclusiveIngredientInitial(ingredientList: newIngredientList));
  }

  void onRemoveIngredientList(
      String ingredientId, List<ExclusiveIngredientEntity> ingredientList) {
    List<ExclusiveIngredientEntity> newIngredientList = [];
    newIngredientList.addAll(ingredientList);
    newIngredientList
        .removeWhere((element) => element.ingredientId == ingredientId);
    emit(ExclusiveIngredientInitial(ingredientList: newIngredientList));
  }

  void onNavigateButtonPressed(
      {required User user,
      List<ExclusiveIngredientEntity> ingredientList = const []}) {
    User newUser = user.copyWith(exclusiveIngredient: ingredientList);
    emit(ExclusiveIngredientSubmit(newUser));
  }
}
