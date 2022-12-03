part of 'bmi_bloc.dart';

abstract class BmiEvent extends Equatable {
  const BmiEvent();
}

class BmiLoadEvent extends BmiEvent {
  @override
  List<Object?> get props => [];
}
