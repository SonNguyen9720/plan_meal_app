part of 'exclusive_ingredient_cubit.dart';

abstract class ExclusiveIngredientState extends Equatable {
  const ExclusiveIngredientState();

  @override
  List<Object> get props => [];
}

class ExclusiveIngredientInitial extends ExclusiveIngredientState {
  final List<String> ingredientIdList;

  const ExclusiveIngredientInitial({this.ingredientIdList = const []});

  @override
  List<Object> get props => [ingredientIdList];
}

class ExclusiveIngredientSubmit extends ExclusiveIngredientState {
  final User user;

  const ExclusiveIngredientSubmit(this.user);
}
