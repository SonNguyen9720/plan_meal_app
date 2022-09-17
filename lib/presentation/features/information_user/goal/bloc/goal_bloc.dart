import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/user.dart';

part 'goal_event.dart';
part 'goal_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  GoalBloc() : super(const GoalInitial([])) {
    on<AddGoalEvent>(_onAddGoalEvent);
    on<RemoveGoalEvent>(_onRemoveGoalEvent);
    on<SubmitListGoalEvent>(_onSubmittingEvent);
  }

  void _onAddGoalEvent(AddGoalEvent event, Emitter<GoalState> emit) {
    var goalList = List<String>.from(state.goalList)..add(event.goal);
    emit(GoalUpdated(goalList));
  }

  void _onRemoveGoalEvent(RemoveGoalEvent event, Emitter<GoalState> emit) {
    var goalList = List<String>.from(state.goalList);
    if (goalList.contains(event.goal)) {
      goalList.remove(event.goal);
      emit(GoalUpdated(goalList));
    }
  }

  void _onSubmittingEvent(SubmitListGoalEvent event, Emitter<GoalState> emit) {
    if (state is GoalUpdated) {
      var user = event.user.copyWith(userGoal: state.goalList);
      emit(GoalSubmit(state.goalList, user));
    }
  }
}
