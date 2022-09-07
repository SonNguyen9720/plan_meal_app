import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_in.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(SignInState initialState) : super(SignInIntialState()) {
    on<SignInPressed>(_signInPressed);
  }

  FutureOr<void> _signInPressed(
      SignInPressed event, Emitter<SignInState> emit) {
    emit(SignInProcessingState());
    try {
      print("email: " + event.email);
      print("password: " + event.password);
    } catch (exception) {
      emit(SignInErrorState(error: exception.toString()));
    }
  }
}
