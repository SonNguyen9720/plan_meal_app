import 'package:plan_meal_app/data/model/diet_type.dart';

enum UserGoal { healthier, energy, consisitent, body }

class User {
  final String name;
  late UserGoal goal;
  final String gender;
  final DateTime birthday;
  final int currentWeight;
  final int goalWeight;
  final int height;
  late DietType dietType;

  User(
      {this.name = "",
      this.gender = "",
      this.currentWeight = 0,
      this.goalWeight = 0,
      this.height = 0})
      : birthday = DateTime.now();

//   User.copyWith(
//       {required this.name,
//       required this.goal,
//       required this.gender,
//       required this.birthday,
//       required this.currentWeight,
//       required this.goalWeight,
//       required this.height,
//       required this.dietType});
// }
}
