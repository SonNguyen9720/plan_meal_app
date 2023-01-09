import 'package:equatable/equatable.dart';

class IncompatiableIngredientEntity extends Equatable {
  final String name;
  final String note;

  const IncompatiableIngredientEntity({required this.name, required this.note});

  @override
  List<Object?> get props => [name, note];


}