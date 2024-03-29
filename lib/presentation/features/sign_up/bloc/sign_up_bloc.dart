import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/config/push_notification_service.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/presentation/features/authentication/authentication.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  SignUpBloc({required this.userRepository, required this.authenticationBloc})
      : super(SignUpInitial()) {
    on<SignUpPressed>(_onSignUpPressed);
  }

  Future<void> _onSignUpPressed(
      SignUpPressed event, Emitter<SignUpState> emit) async {
    try {
      emit(SignUpProcessing());
      final String email = event.email;
      final String password = event.password;
      PushNotificationService pushNotificationService = PushNotificationService();
      String deviceToken = await pushNotificationService.getToken() ?? "";

      String token =
          await userRepository.signUp(email: email, password: password, deviceToken: deviceToken);
      authenticationBloc.add(LoggedIn(token));
      await userRepository.updateUserProfile(
        firstName: event.user.firstName,
        sex: event.user.gender,
        lastName: event.user.lastName,
        dob: event.user.birthday,
        height: event.user.height,
        weight: event.user.currentWeight,
        imageUrl: event.user.imageUrl,
        healthGoal: event.user.userGoal,
        desiredWeight: event.user.goalWeight,
        activityIntensity: event.user.activityIntensity,
        token: token,
      );
      if (event.user.exclusiveIngredient.isNotEmpty) {
        List<String> ingredientIdList = [];
        for (var ingredient in event.user.exclusiveIngredient) {
          ingredientIdList.add(ingredient.ingredientId);
        }
        await userRepository.postAllergicIngredient(ingredientIdList);
      }
      emit(SignUpFinished());
    } catch (error) {
      emit(SignUpError(error.toString()));
    }
  }
}
