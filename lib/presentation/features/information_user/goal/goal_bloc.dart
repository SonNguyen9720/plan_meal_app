import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:plan_meal_app/presentation/features/information_user/goal/goal.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  GoalBloc(GoalState initialState) : super(initialState) {
    on<GoalStarted>(onStarted);
    on<GoalItemAdded>(onItemAdded);
    on<GoalItemRemoved>(onItemRemoved);
  }

  FutureOr<void> onStarted(GoalStarted event, Emitter<GoalState> emit) {}

  FutureOr<void> onItemAdded(GoalItemAdded event, Emitter<GoalState> emit) {}

  FutureOr<void> onItemRemoved(
      GoalItemRemoved event, Emitter<GoalState> emit) {}
}
