import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/domain/entities/activity_intensity_entity.dart';

part 'activity_intensity_event.dart';

part 'activity_intensity_state.dart';

class ActivityIntensityBloc
    extends Bloc<ActivityIntensityEvent, ActivityIntensityState> {
  ActivityIntensityBloc()
      : super(const ActivityIntensityInitial(activityIntensityMap: {
          ActivityIntensity.sedentary: false,
          ActivityIntensity.lightly_active: false,
          ActivityIntensity.moderately_active: false,
          ActivityIntensity.very_active: false,
          ActivityIntensity.extra_active: false,
        })) {
    on<ActivityIntensityChoose>(_onActivityIntensityChoose);
    on<ActivityIntensitySubmit>(_onActivityIntensitySubmit);
  }

  void _onActivityIntensityChoose(
      ActivityIntensityChoose event, Emitter<ActivityIntensityState> emit) {
    if (state is ActivityIntensityInitial) {
      var activityIntensityMap = Map<ActivityIntensity, bool>.from(
          (state as ActivityIntensityInitial).activityIntensityMap);
      ActivityIntensity activityIntensity = ActivityIntensity.empty;
      switch (event.index) {
        case 0:
          activityIntensity = ActivityIntensity.sedentary;
          break;
        case 1:
          activityIntensity = ActivityIntensity.lightly_active;
          break;
        case 2:
          activityIntensity = ActivityIntensity.moderately_active;
          break;
        case 3:
          activityIntensity = ActivityIntensity.very_active;
          break;
        case 4:
          activityIntensity = ActivityIntensity.extra_active;
          break;
      }
      activityIntensityMap.updateAll((key, value) => false);
      activityIntensityMap.update(activityIntensity, (value) => true);
      print("Update state");
      emit(ActivityIntensityUpdated(activityIntensity, activityIntensityMap));
      emit(ActivityIntensityInitial(
          activityIntensityMap: activityIntensityMap,
          render: activityIntensityMap.values.toList()));
    }
  }

  void _onActivityIntensitySubmit(
      ActivityIntensitySubmit event, Emitter<ActivityIntensityState> emit) {

    String activityIntensity = event.activityIntensity.name;
    User newUser = event.user.copyWith(activityIntensity: activityIntensity);
    print(newUser.activityIntensity);

    emit(ActivityIntensitySubmitted(newUser, activityIntensity));
  }
}
