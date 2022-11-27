part of 'ingredient_bloc.dart';

abstract class IngredientState extends Equatable {
  const IngredientState();
  
  @override
  List<Object> get props => [];
}

class IngredientInitial extends IngredientState {
  final List<IngredientDetailEntity> listIngredientDetailEntity;

  const IngredientInitial({this.listIngredientDetailEntity = const []});
  @override
  List<Object> get props => [listIngredientDetailEntity];
}

class IngredientLoading extends IngredientState {}

class IngredientFinished extends IngredientState {}
