part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
}

class ChangePasswordSendPassword extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordSendPassword({required this.oldPassword, required this.newPassword});
  @override
  List<Object?> get props => [];
}
