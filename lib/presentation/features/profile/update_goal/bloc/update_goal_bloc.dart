import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/user_repository_remote.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';

part 'update_goal_event.dart';

part 'update_goal_state.dart';

class UpdateGoalBloc extends Bloc<UpdateGoalEvent, UpdateGoalState> {
  final UserRepository userRepository;

  UpdateGoalBloc({required this.userRepository})
      : super(const UpdateGoalInitial(currentWeight: "", goalWeight: "")) {
    on<UpdateGoalLoadEvent>((event, emit) {
      String currentWeight = PreferenceUtils.getString("weight") ?? "";
      String goalWeight = PreferenceUtils.getString("goalWeight") ?? "";
      emit(UpdateGoalInitial(
          currentWeight: currentWeight, goalWeight: goalWeight));
    });

    on<UpdateGoalSendEvent>((event, emit) async {
      emit(UpdateGoalWaiting());
      String currentWeight = PreferenceUtils.getString("weight") ?? "";
      int currentWeightDTO = int.parse(event.currentWeight);
      int userId = int.parse(PreferenceUtils.getString("userId") ?? "0");
      String firstName = PreferenceUtils.getString("firstName") ?? "";
      String lastName = PreferenceUtils.getString("lastName") ?? "";
      String sex = PreferenceUtils.getString("sex") ?? "";
      String dob = PreferenceUtils.getString("dob") ?? "";
      int height = int.parse(PreferenceUtils.getString("height") ?? "0");
      String imageUrl = PreferenceUtils.getString("imageUrl") ?? "";
      String healthGoal = PreferenceUtils.getString("healthGoal") ?? "";
      int desiredWeight =
          int.parse(PreferenceUtils.getString("goalWeight") ?? "0");
      String activityIntensity =
          PreferenceUtils.getString("activityIntensity") ?? "";
      String email = PreferenceUtils.getString("email") ?? "";
      String statusCodeUpdate = await userRepository.updateUserInfo(
          id: userId,
          firstName: firstName,
          lastName: lastName,
          sex: sex,
          dob: dob,
          height: height,
          weight: currentWeightDTO,
          imageUrl: imageUrl,
          healthGoal: healthGoal,
          desiredWeight: desiredWeight,
          activityIntensity: activityIntensity,
          email: email);

      if (currentWeight != currentWeightDTO.toString()) {
        String statusCodeTrack =
          await userRepository.updateWeight(currentWeightDTO);
      }
      emit(UpdateGoalFinished());
    });
  }
}
