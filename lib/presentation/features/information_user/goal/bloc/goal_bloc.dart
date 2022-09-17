import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/user.dart';

part 'goal_event.dart';
part 'goal_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  GoalBloc() : super(const GoalInitial([])) {
    on<AddGoalEvent>(_onAddGoalEvent);
    on<RemoveGoalEvent>(_onRemoveGoalEvent);
    on<SubmitListGoalEvent>(_onSubmitingEvent);
  }

  void _onAddGoalEvent(AddGoalEvent event, Emitter<GoalState> emit) {
    state.goalList.add(event.goal);
    emit(GoalUpdated(state.goalList));
  }

  void _onRemoveGoalEvent(RemoveGoalEvent event, Emitter<GoalState> emit) {
    if (state.goalList.contains(event.goal)) {
      state.goalList.remove(event.goal);
      emit(GoalUpdated(state.goalList));
    }
  }

  void _onSubmitingEvent(SubmitListGoalEvent event, Emitter<GoalState> emit) {
    if (state is GoalUpdated) {
      emit(GoalSubmit(state.goalList, event.user));
    }
  }
}
