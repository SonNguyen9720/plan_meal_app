import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/user.dart';

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
    String activityIntensity = event.activityIntensity;
    emit(ActivityIntensityUpdated(activityIntensity));
  }

  void _onActivityIntensitySubmit(
      ActivityIntensitySubmit event, Emitter<ActivityIntensityState> emit) {}
}
