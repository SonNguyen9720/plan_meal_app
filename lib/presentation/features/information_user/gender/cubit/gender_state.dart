part of 'gender_cubit.dart';

abstract class GenderState extends Equatable {
  const GenderState();

  @override
  List<Object> get props => [];
}

class GenderInitial extends GenderState {}

class GenderUpdated extends GenderState {
  final User user;

  const GenderUpdated(this.user);
}

class GenderFinished extends GenderState {}
