part of 'bmi_bloc.dart';

abstract class BmiState extends Equatable {
  const BmiState();
}

class BmiLoading extends BmiState {
  @override
  List<Object?> get props => [];
}

class BmiInitial extends BmiState {
  final String bmi;
  final String type;

  const BmiInitial({required this.bmi, required this.type});

  @override
  List<Object> get props => [];
}
