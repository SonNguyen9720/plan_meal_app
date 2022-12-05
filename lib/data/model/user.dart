import 'package:equatable/equatable.dart';

enum UserGoal { healthier, energy, consistent, body }

class User extends Equatable {
  final String firstName;
  final String lastName;
  final String userGoal;
  final String imageUrl;
  final String gender;
  final String birthday;
  final int currentWeight;
  final int goalWeight;
  final int height;
  final String activityIntensity;

  User(
      {this.firstName = "",
        this.lastName = "",
      this.gender = "",
      this.imageUrl = "",
      this.currentWeight = 0,
      this.goalWeight = 0,
      this.height = 0,
      this.userGoal = "",
      this.birthday = "",
      this.activityIntensity = ""});

  User copyWith(
      {String? firstName,
        String? lastName,
      String? userGoal,
      String? gender,
      String? imageUrl,
      String? birthday,
      int? currentWeight,
      int? goalWeight,
      int? height,
      String? activityIntensity}) {
    return User(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        userGoal: userGoal ?? this.userGoal,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        currentWeight: currentWeight ?? this.currentWeight,
        goalWeight: goalWeight ?? this.goalWeight,
        height: height ?? this.height,
        activityIntensity: activityIntensity ?? this.activityIntensity);
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        userGoal,
        imageUrl,
        gender,
        birthday,
        currentWeight,
        goalWeight,
        height,
        activityIntensity
      ];
}
