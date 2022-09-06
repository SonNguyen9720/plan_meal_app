import 'package:flutter_bloc/flutter_bloc.dart';
import 'sign_in.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(SignInState initialState) : super(initialState) {
    on<SignInPressed>(onSignInPressed);
  }

  void onSignInPressed(SignInEvent event , Emitter<void> emit) {
    emit(SignInProcessingState());
    try {
      emit(SignInFinishedState());
    } catch (error) {
      emit(SignInErrorState(error.toString()));
    }
  }

}