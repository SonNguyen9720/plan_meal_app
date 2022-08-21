import 'package:equatable/equatable.dart';

abstract class GoalState extends Equatable {
  @override
  List<Object> get props => [];
}

class GoalLoading extends GoalState {}
