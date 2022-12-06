part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
}

class ChangePasswordInitial extends ChangePasswordState {
  @override
  List<Object> get props => [];
}

class ChangePasswordWaiting extends ChangePasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChangePasswordFinished extends ChangePasswordState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordSuccess extends ChangePasswordState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordFailed extends ChangePasswordState {
  final String message;

  const ChangePasswordFailed({required this.message});
  @override
  List<Object?> get props => [];
}
