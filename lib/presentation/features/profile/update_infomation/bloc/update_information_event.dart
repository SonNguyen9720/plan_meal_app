part of 'update_information_bloc.dart';

abstract class UpdateInformationEvent extends Equatable {
  const UpdateInformationEvent();
}

class UpdateInformationSendEvent extends UpdateInformationEvent {
  final String height;
  final String healthGoal;
  final String activityIntensity;

  const UpdateInformationSendEvent({required this.height, required this.healthGoal, required this.activityIntensity});

  @override
  List<Object?> get props => [height, healthGoal, activityIntensity];

}
