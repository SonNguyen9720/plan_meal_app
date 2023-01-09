part of 'home_member_bloc.dart';

abstract class HomeMemberEvent extends Equatable {
  final String memberId;
  const HomeMemberEvent({required this.memberId});

  @override
  List<Object?> get props => [];
}

class HomeGetUserEvent extends HomeMemberEvent {
  const HomeGetUserEvent({required String memberId}) : super(memberId: memberId);
}

class HomeGetBMI extends HomeMemberEvent {
  const HomeGetBMI({required String memberId}) : super(memberId: memberId);
}

class HomeGetUserOverviewEvent extends HomeMemberEvent {
  final DateTime dateTime;

  const HomeGetUserOverviewEvent({required this.dateTime, required memberId}) : super(memberId: memberId);
}
