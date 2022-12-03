import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';

part 'update_goal_event.dart';
part 'update_goal_state.dart';

class UpdateGoalBloc extends Bloc<UpdateGoalEvent, UpdateGoalState> {
  UpdateGoalBloc() : super(const UpdateGoalInitial(currentWeight: "", goalWeight: "")) {
    on<UpdateGoalEvent>((event, emit) {
      String currentWeight = PreferenceUtils.getString("weight") ?? "";
      String goalWeight = PreferenceUtils.getString("goalWeight") ?? "";
      emit(UpdateGoalInitial(currentWeight: currentWeight, goalWeight: goalWeight));
    });
  }
}
