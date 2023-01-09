part of 'bmi_bloc.dart';

abstract class BmiMemberState extends Equatable {
  const BmiMemberState();
}

class BmiLoading extends BmiMemberState {
  @override
  List<Object?> get props => [];
}

class BmiInitial extends BmiMemberState {
  final String bmi;
  final String type;

  const BmiInitial({required this.bmi, required this.type});

  @override
  List<Object> get props => [];
}
