part of 'birthday_cubit.dart';

abstract class BirthdayState extends Equatable {
  const BirthdayState();

  @override
  List<Object> get props => [];
}

class BirthdayInitial extends BirthdayState {}

class BirthdayStoraged extends BirthdayState {
  final User user;

  const BirthdayStoraged(this.user);
}

class BirthdayFinished extends BirthdayState {}

class BirthdayError extends BirthdayState {
  final String error;

  const BirthdayError(this.error);
}
