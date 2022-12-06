import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final UserRepository userRepository;

  ChangePasswordBloc({required this.userRepository}) : super(ChangePasswordInitial()) {
    on<ChangePasswordSendPassword>(_onChangePasswordSendPassword);
  }

  void _onChangePasswordSendPassword(ChangePasswordSendPassword event, Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordWaiting());
    String result = await userRepository.changePassword(event.oldPassword, event.newPassword);
    emit(ChangePasswordFinished());
    if (result == "200") {
      emit(ChangePasswordSuccess());
    } else {
      emit(ChangePasswordFailed(message: result));
    }
  }
}
