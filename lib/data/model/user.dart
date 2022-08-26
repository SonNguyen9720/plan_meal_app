import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/diet_type.dart';

enum UserGoal { healthier, energy, consisitent, body }

class User extends Equatable {
  final String name;
  final UserGoal goal;
  final String gender;
  final DateTime birthday;
  final int currentWeight;
  final int goalWeight;
  final int height;
  final DietType dietType;

  const User(this.name, this.goal, this.gender, this.birthday,
      this.currentWeight, this.goalWeight, this.height, this.dietType);

  @override
  List<Object?> get props => [
        name,
        goal,
        gender,
        birthday,
        currentWeight,
        goalWeight,
        height,
        dietType
      ];
}
