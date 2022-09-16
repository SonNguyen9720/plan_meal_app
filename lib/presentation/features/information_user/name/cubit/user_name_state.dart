part of 'user_name_cubit.dart';

abstract class UserNameState extends Equatable {
  const UserNameState();

  @override
  List<Object> get props => [];
}

class UserNameInitial extends UserNameState {}

class UserNameStoraged extends UserNameState {
  final User user;

  const UserNameStoraged({required this.user});

  @override
  List<Object> get props => [user];
}

class UserNameFinished extends UserNameState {}
