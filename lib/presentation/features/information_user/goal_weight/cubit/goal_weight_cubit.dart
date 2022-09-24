import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/user.dart';

part 'goal_weight_state.dart';

class GoalWeightCubit extends Cubit<GoalWeightState> {
  GoalWeightCubit() : super(GoalWeightInitial());
}
