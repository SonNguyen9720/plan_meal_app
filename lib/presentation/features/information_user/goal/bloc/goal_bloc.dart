import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/user.dart';

part 'goal_event.dart';
part 'goal_state.dart';

enum HealthGoal {
  eat_healthier,
  boost_energy,
  stay_motivated,
  feed_better,
  empty,
}

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  GoalBloc() : super(const GoalInitial()) {
    on<UpdateGoalEvent>(_onUpdateGoalEvent);
    on<SubmitListGoalEvent>(_onSubmittingEvent);
  }

  void _onUpdateGoalEvent(UpdateGoalEvent event, Emitter<GoalState> emit) {
    if (state is GoalInitial) {
      var healthGoalMap = Map<HealthGoal, bool>.from(
          (state as GoalInitial).healthGoalMap);
      HealthGoal healthGoal = HealthGoal.empty;
      switch (event.index) {
        case 0:
          healthGoal = HealthGoal.eat_healthier;
          break;
        case 1:
          healthGoal = HealthGoal.boost_energy;
          break;
        case 2:
          healthGoal = HealthGoal.feed_better;
          break;
        case 3:
          healthGoal = HealthGoal.stay_motivated;
          break;
      }
      healthGoalMap.updateAll((key, value) => false);
      healthGoalMap.update(healthGoal, (value) => true);
      print("Update state");
      emit(GoalUpdated(healthGoalMap, healthGoal));
      emit(GoalInitial(
          healthGoalMap: healthGoalMap,
          render: healthGoalMap.values.toList()));
    } else if (state is GoalSubmit){
      emit(const GoalInitial());
      var healthGoalMap = Map<HealthGoal, bool>.from(
          (state as GoalInitial).healthGoalMap);
      HealthGoal healthGoal = HealthGoal.empty;
      switch (event.index) {
        case 0:
          healthGoal = HealthGoal.eat_healthier;
          break;
        case 1:
          healthGoal = HealthGoal.boost_energy;
          break;
        case 2:
          healthGoal = HealthGoal.stay_motivated;
          break;
        case 3:
          healthGoal = HealthGoal.feed_better;
          break;
      }
      healthGoalMap.updateAll((key, value) => false);
      healthGoalMap.update(healthGoal, (value) => true);
      print("Update state");
      emit(GoalUpdated(healthGoalMap, healthGoal));
      emit(GoalInitial(
          healthGoalMap: healthGoalMap,
          render: healthGoalMap.values.toList()));
    }
  }

  // void _onAddGoalEvent(AddGoalEvent event, Emitter<GoalState> emit) {
  //   var goalList = List<String>.from(state.goalList)..add(event.goal);
  //   emit(GoalUpdated(goalList));
  // }
  //
  // void _onRemoveGoalEvent(RemoveGoalEvent event, Emitter<GoalState> emit) {
  //   var goalList = List<String>.from(state.goalList);
  //   if (goalList.contains(event.goal)) {
  //     goalList.remove(event.goal);
  //     emit(GoalUpdated(goalList));
  //   }
  // }

  void _onSubmittingEvent(SubmitListGoalEvent event, Emitter<GoalState> emit) {
    var user = event.user.copyWith(userGoal: event.healthGoal.name);
    print(user.userGoal);
    emit(GoalSubmit(event.healthGoal.toString(), user));
  }
}
