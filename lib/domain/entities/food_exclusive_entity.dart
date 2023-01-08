import 'package:equatable/equatable.dart';

class FoodExclusiveEntity extends Equatable {
  final String id;
  final String name;

  const FoodExclusiveEntity({required this.id ,required this.name});

  @override
  List<Object?> get props => [id, name];
}