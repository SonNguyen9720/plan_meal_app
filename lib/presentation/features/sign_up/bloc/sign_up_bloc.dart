import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

      String token =
          await userRepository.signUp(email: email, password: password);
      authenticationBloc.add(LoggedIn(token));
      String result = await userRepository.postUserProfile(event.user, email, token);

      emit(SignUpFinished());
    } catch (error) {
      emit(SignUpError(error.toString()));
    }
  }
}
