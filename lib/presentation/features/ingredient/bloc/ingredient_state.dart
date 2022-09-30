part of 'ingredient_bloc.dart';

abstract class IngredientState extends Equatable {
  const IngredientState();
  
  @override
  List<Object> get props => [];
}

class IngredientInitial extends IngredientState {}
