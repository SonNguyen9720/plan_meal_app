part of 'ingredient_detail_bloc.dart';

abstract class IngredientDetailState extends Equatable {
  const IngredientDetailState();

  @override
  List<Object> get props => [];
}

class IngredientDetailInitial extends IngredientDetailState {}

class IngredientDetailLoading extends IngredientDetailState {}

class IngredientDetailFailed extends IngredientDetailState {}

class IngredientDetailSuccess extends IngredientDetailState {
  final List<IncompatiableIngredientEntity> ingredientList;

  const IngredientDetailSuccess({required this.ingredientList});

  @override
  List<Object> get props => [ingredientList];
}
