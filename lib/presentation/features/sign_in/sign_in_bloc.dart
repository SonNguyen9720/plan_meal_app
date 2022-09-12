import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
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
    try {
      print("email: " + event.email);
      print("password: " + event.password);
      var token = await userRepository.signIn(
          email: event.email, password: event.password);
      authenticationBloc.add(LoggedIn(token));
      emit(SignInFinishedState());
    } catch (exception) {
      emit(SignInErrorState(error: exception.toString()));
    }
  }
}
