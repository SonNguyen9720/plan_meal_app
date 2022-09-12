part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpProcessing extends SignUpState {}

class SignUpError extends SignUpState {
  final String error;

  const SignUpError(this.error);

  @override
  List<Object> get props => [error];
}

class SignUpFinished extends SignUpState {}
