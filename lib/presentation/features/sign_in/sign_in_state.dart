import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool status;
  final String? errorMessage;

  const LoginState(
      {this.email = '',
      this.password = '',
      this.status = true,
      this.errorMessage});

  @override
  List<Object?> get props => [email, password, status];

  LoginState copyWith(
      {String? email, String? password, bool? status, String? errorMessage}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
