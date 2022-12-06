part of 'update_information_bloc.dart';

abstract class UpdateInformationEvent extends Equatable {
  const UpdateInformationEvent();
}

class UpdateInformationSendEvent extends UpdateInformationEvent {
  final String firstName;
  final String lastName;
  final String sex;
  final String dob;
  final String height;
  final String healthGoal;
  final String activityIntensity;

  const UpdateInformationSendEvent(
      {required this.firstName,
      required this.lastName,
      required this.sex,
      required this.dob,
      required this.height,
      required this.healthGoal,
      required this.activityIntensity});

  @override
  List<Object?> get props =>
      [firstName, lastName, sex, dob, height, healthGoal, activityIntensity];
}
