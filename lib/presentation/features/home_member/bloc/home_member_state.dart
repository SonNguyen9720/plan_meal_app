part of 'home_member_bloc.dart';

abstract class HomeMemberState extends Equatable {
  const HomeMemberState();
}

class HomeInitial extends HomeMemberState {
  final UserOverviewEntity? userOverviewEntity;

  const HomeInitial({this.userOverviewEntity});

  @override
  List<Object?> get props => [userOverviewEntity];
}

class HomeLoading extends HomeMemberState {
  @override
  List<Object> get props => [];
}

class HomeError extends HomeMemberState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
