part of 'activity_intensity_bloc.dart';

abstract class ActivityIntensityEvent extends Equatable {
  const ActivityIntensityEvent();

  @override
  List<Object> get props => [];
}

class ActivityIntensityChoose extends ActivityIntensityEvent {
  final String activityIntensity;

  const ActivityIntensityChoose(this.activityIntensity);
}

class ActivityIntensitySubmit extends ActivityIntensityEvent {
  final String activityIntensity;
  final User user;

  const ActivityIntensitySubmit(this.activityIntensity, this.user);
}
