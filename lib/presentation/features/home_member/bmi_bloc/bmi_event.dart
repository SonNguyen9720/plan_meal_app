part of 'bmi_bloc.dart';

abstract class BmiMemberEvent extends Equatable {
  const BmiMemberEvent();
}

class BmiLoadEvent extends BmiMemberEvent {
  final String member;
  const BmiLoadEvent({required this.member});
  @override
  List<Object?> get props => [member];
}
