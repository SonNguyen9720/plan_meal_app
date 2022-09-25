enum UserGoal { healthier, energy, consistent, body }

class User {
  final String name;
  final List<String>? userGoal;
  final String gender;
  final DateTime? birthday;
  final int currentWeight;
  final int goalWeight;
  final int height;
  final String dietType;

  User(
      {this.name = "",
      this.gender = "",
      this.currentWeight = 0,
      this.goalWeight = 0,
      this.height = 0,
      this.userGoal,
      this.birthday,
      this.dietType = ""});

  User copyWith(
      {String? name,
      List<String>? userGoal,
      String? gender,
      DateTime? birthday,
      int? currentWeight,
      int? goalWeight,
      int? height,
      String? dietType}) {
    return User(
        name: name ?? this.name,
        userGoal: userGoal ?? this.userGoal,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        currentWeight: currentWeight ?? this.currentWeight,
        goalWeight: goalWeight ?? this.goalWeight,
        height: height ?? this.height,
        dietType: dietType ?? this.dietType);
  }
}
