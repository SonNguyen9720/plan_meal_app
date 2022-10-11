part of 'height_cubit.dart';

abstract class HeightState extends Equatable {
  const HeightState();

  @override
  List<Object> get props => [];
}

class HeightInitial extends HeightState {}

class HeightStored extends HeightState {
  final User user;

  const HeightStored(this.user);
}
