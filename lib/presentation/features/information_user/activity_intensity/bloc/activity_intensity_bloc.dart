import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/domain/entities/activity_intensity_entity.dart';

part 'activity_intensity_event.dart';
part 'activity_intensity_state.dart';

class ActivityIntensityBloc
    extends Bloc<ActivityIntensityEvent, ActivityIntensityState> {
  ActivityIntensityBloc() : super(ActivityIntensityInitial()) {
    on<ActivityIntensityChoose>(_onActivityIntensityChoose);
    on<ActivityIntensitySubmit>(_onActivityIntensitySubmit);
  }

  void _onActivityIntensityChoose(
      ActivityIntensityChoose event, Emitter<ActivityIntensityState> emit) {
    if (state is ActivityIntensityInitial) {
      var activityIntensityMap =
          (state as ActivityIntensityInitial).activityIntensityMap;
      ActivityIntensity activityIntensity = ActivityIntensity.empty;
      switch (event.index) {
        case 0:
          activityIntensity = ActivityIntensity.notVeryActive;
          break;
        case 1:
          activityIntensity = ActivityIntensity.lightlyActive;
          break;
        case 2:
          activityIntensity = ActivityIntensity.active;
          break;
        case 3:
          activityIntensity = ActivityIntensity.veryActive;
          break;
      }
      activityIntensityMap.update(activityIntensity, (value) => true);
      emit(ActivityIntensityUpdated(activityIntensity, activityIntensityMap));
    }
  }

  void _onActivityIntensitySubmit(
      ActivityIntensitySubmit event, Emitter<ActivityIntensityState> emit) {
    User newUser = event.user.copyWith();
    String activityIntensity = event.activityIntensity;

    emit(ActivityIntensitySubmitted(newUser, activityIntensity));
  }
}
