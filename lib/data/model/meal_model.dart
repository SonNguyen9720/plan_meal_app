import 'package:equatable/equatable.dart';

class MealModel extends Equatable {
  final String id;
  final String meal;

  const MealModel({required this.id, required this.meal});

  @override
  List<Object> get props => [id, meal];
}