import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/push_notification_service.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/presentation/features/authentication/authentication.dart';

import 'sign_in.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  SignInBloc({required this.userRepository, required this.authenticationBloc})
      : super(SignInInitialState()) {
    on<SignInPressed>(_signInPressed);
  }

  Future<void> _signInPressed(
      SignInPressed event, Emitter<SignInState> emit) async {
    emit(SignInProcessingState());
    PushNotificationService pushNotificationService = PushNotificationService();
    String deviceToken = await pushNotificationService.getToken() ?? "";
    try {
      if (kDebugMode) {
        print("email: " + event.email);
        print("password: " + event.password);
        print("token: " + deviceToken);
      }
      var token = await userRepository.signIn(
          email: event.email,
          password: event.password,
          deviceToken: deviceToken);
      authenticationBloc.add(LoggedIn(token));
      emit(SignInFinishedState());
    } catch (exception) {
      emit(SignInErrorState(error: exception.toString()));
    }
  }
}
