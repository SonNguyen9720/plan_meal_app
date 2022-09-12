import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';

import 'sign_in.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository userRepository;
  SignInBloc({required this.userRepository}) : super(SignInInitialState()) {
    on<SignInPressed>(_signInPressed);
  }

  FutureOr<void> _signInPressed(
      SignInPressed event, Emitter<SignInState> emit) {
    emit(SignInProcessingState());
    try {
      print("email: " + event.email);
      print("password: " + event.password);
      var token =
          userRepository.signIn(email: event.email, password: event.password);
    } catch (exception) {
      emit(SignInErrorState(error: exception.toString()));
    }
  }
}
