import 'package:equatable/equatable.dart';

class UserInformationEntity extends Equatable {
  final int userId;
  final String firstName;
  final String lastName;
  final String sex;
  final String dob;
  final int height;
  final int weight;
  final String imageUrl;
  final String healthGoal;
  final int desiredWeight;
  final String activityIntensity;
  final String email;

  const UserInformationEntity({
    required this.userId,
    this.firstName = "",
    this.lastName = "",
    this.sex = "male",
    required this.dob,
    this.height = 0,
    this.weight = 0,
    this.imageUrl = "",
    this.healthGoal = "",
    this.desiredWeight = 0,
    this.activityIntensity = "",
    this.email = "",
  });

  @override
  List<Object> get props => [
        userId,
        firstName,
        lastName,
        sex,
        dob,
        height,
        weight,
        imageUrl,
        healthGoal,
        desiredWeight,
        activityIntensity,
        email,
      ];

  UserInformationEntity copyWith({
    int? userId,
    String? firstName,
    String? lastName,
    String? sex,
    String? dob,
    int? height,
    int? weight,
    String? imageUrl,
    String? healthGoal,
    int? desiredWeight,
    String? activityIntensity,
    String? email,
  }) {
    return UserInformationEntity(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      sex: sex ?? this.sex,
      dob: dob ?? this.dob,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      imageUrl: imageUrl ?? this.imageUrl,
      healthGoal: healthGoal ?? this.healthGoal,
      desiredWeight: desiredWeight ?? this.desiredWeight,
      activityIntensity: activityIntensity ?? this.activityIntensity,
      email: email ?? this.email,
    );
  }
}
