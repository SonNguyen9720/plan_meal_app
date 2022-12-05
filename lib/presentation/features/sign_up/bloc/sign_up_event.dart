part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpPressed extends SignUpEvent {
  final String email;
  final String password;
  final User user;

  const SignUpPressed(
      {required this.email, required this.password, required this.user});

  @override
  List<Object> get props => [email, password, user];
}
