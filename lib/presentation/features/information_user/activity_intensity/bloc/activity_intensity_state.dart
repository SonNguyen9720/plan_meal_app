part of 'activity_intensity_bloc.dart';

abstract class ActivityIntensityState extends Equatable {
  const ActivityIntensityState();

  @override
  List<Object> get props => [];
}

class ActivityIntensityInitial extends ActivityIntensityState {
  final Map<ActivityIntensity, bool> activityIntensityMap;
  final List<bool> render;

  const ActivityIntensityInitial(
      {required this.activityIntensityMap,
      this.render = const [false, false, false, false, false]});
}

class ActivityIntensityUpdated extends ActivityIntensityState {
  final ActivityIntensity activityIntensity;
  final Map<ActivityIntensity, bool> activityIntensityListMap;

  const ActivityIntensityUpdated(
      this.activityIntensity, this.activityIntensityListMap);
}

class ActivityIntensitySubmitted extends ActivityIntensityState {
  final User user;
  final String activityIntensity;

  const ActivityIntensitySubmitted(this.user, this.activityIntensity);
}
