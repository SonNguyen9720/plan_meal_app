part of 'ingredient_detail_bloc.dart';

abstract class IngredientDetailEvent extends Equatable {
  const IngredientDetailEvent();

  @override
  List<Object> get props => [];
}

class IngredientDetailLoadEvent extends IngredientDetailEvent {}
