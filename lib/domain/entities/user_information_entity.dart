import 'package:equatable/equatable.dart';

class UserInformationEntity extends Equatable {
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

  const UserInformationEntity({
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
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        sex,
        dob,
        height,
        weight,
        imageUrl,
        healthGoal,
        desiredWeight,
        activityIntensity
      ];

  UserInformationEntity copyWith(
      {String? firstName,
      String? lastName,
      String? sex,
      String? dob,
      int? height,
      int? weight,
      String? imageUrl,
      String? healthGoal,
      int? desiredWeight,
      String? activityIntensity}) {
    return UserInformationEntity(
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
    );
  }
}
