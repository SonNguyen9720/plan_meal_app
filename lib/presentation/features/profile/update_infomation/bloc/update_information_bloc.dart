import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';

part 'update_information_event.dart';
part 'update_information_state.dart';

class UpdateInformationBloc extends Bloc<UpdateInformationEvent, UpdateInformationState> {
  final UserRepository userRepository;

  UpdateInformationBloc({required this.userRepository}) : super(UpdateInformationInitial()) {
    on<UpdateInformationSendEvent>((event, emit) async {
      emit(UpdateInformationWaiting());
      int weight = int.parse(PreferenceUtils.getString("weight") ?? "0");
      int userId = int.parse(PreferenceUtils.getString("userId") ?? "0");
      String firstName = PreferenceUtils.getString("firstName") ?? "";
      String lastName = PreferenceUtils.getString("lastName") ?? "";
      String sex = PreferenceUtils.getString("sex") ?? "";
      String dob = PreferenceUtils.getString("dob") ?? "";
      int height = int.parse(event.height);
      int age = int.parse(PreferenceUtils.getString("age") ?? "0");
      String imageUrl = PreferenceUtils.getString("imageUrl") ?? "";
      String healthGoal = event.healthGoal;
      int desiredWeight = int.parse(PreferenceUtils.getString("goalWeight") ?? "0");
      String activityIntensity = event.activityIntensity;
      String email = PreferenceUtils.getString("email") ?? "";
      String statusCodeUpdate = await userRepository.updateUserInfo(
          id: userId,
          firstName: firstName,
          lastName: lastName,
          sex: sex,
          dob: dob,
          height: height,
          weight: weight,
          age: age,
          imageUrl: imageUrl,
          healthGoal: healthGoal,
          desiredWeight: desiredWeight,
          activityIntensity: activityIntensity,
          email: email);
      emit(UpdateInformationFinished());
    });
  }
}
