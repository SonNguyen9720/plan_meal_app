part of 'activity_intensity_bloc.dart';

abstract class ActivityIntensityState extends Equatable {
  const ActivityIntensityState();

  @override
  List<Object> get props => [];
}

class ActivityIntensityInitial extends ActivityIntensityState {}

class ActivityIntensityUpdated extends ActivityIntensityState {
  final String activityIntensity;

  const ActivityIntensityUpdated(this.activityIntensity);
}

class ActivityIntensitySubmitted extends ActivityIntensityState {
  final User user;
  final String activityIntensity;

  const ActivityIntensitySubmitted(this.user, this.activityIntensity);
}
