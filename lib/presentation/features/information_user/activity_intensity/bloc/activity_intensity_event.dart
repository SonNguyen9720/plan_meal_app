part of 'activity_intensity_bloc.dart';

abstract class ActivityIntensityEvent extends Equatable {
  const ActivityIntensityEvent();

  @override
  List<Object> get props => [];
}

class ActivityIntensityChoose extends ActivityIntensityEvent {
  final int index;
  const ActivityIntensityChoose(this.index);
}

class ActivityIntensitySubmit extends ActivityIntensityEvent {
  final ActivityIntensity activityIntensity;
  final User user;

  const ActivityIntensitySubmit(this.activityIntensity, this.user);
}
