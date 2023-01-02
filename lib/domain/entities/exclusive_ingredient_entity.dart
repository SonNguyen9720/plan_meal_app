import 'package:equatable/equatable.dart';

class ExclusiveIngredientEntity extends Equatable {
  final String ingredientId;
  final String ingredientName;

  const ExclusiveIngredientEntity(
      {required this.ingredientId, required this.ingredientName});

  @override
  List<Object> get props => [];
}
