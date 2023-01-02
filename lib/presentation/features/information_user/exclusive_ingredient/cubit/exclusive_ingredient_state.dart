part of 'exclusive_ingredient_cubit.dart';

abstract class ExclusiveIngredientState extends Equatable {
  const ExclusiveIngredientState();

  @override
  List<Object> get props => [];
}

class ExclusiveIngredientInitial extends ExclusiveIngredientState {
  final List<ExclusiveIngredientEntity> ingredientList;

  const ExclusiveIngredientInitial({this.ingredientList = const []});

  @override
  List<Object> get props => [ingredientList];
}

class ExclusiveIngredientSubmit extends ExclusiveIngredientState {
  final User user;

  const ExclusiveIngredientSubmit(this.user);
}
