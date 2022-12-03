import 'package:equatable/equatable.dart';

class UserOverviewEntity extends Equatable {
  double? baseCalories;
  int? currentCalories;
  int? totalCalories;
  int? protein;
  int? fat;
  int? carb;

  UserOverviewEntity(
      {this.baseCalories,
      this.currentCalories,
      this.totalCalories,
      this.protein,
      this.fat,
      this.carb});

  @override
  List<Object?> get props =>
      [baseCalories, currentCalories, totalCalories, protein, fat, carb];
}
