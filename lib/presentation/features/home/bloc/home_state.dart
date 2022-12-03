part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  final UserOverviewEntity? userOverviewEntity;

  const HomeInitial({this.userOverviewEntity});

  @override
  List<Object?> get props => [userOverviewEntity];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}
