part of 'marketer_bloc.dart';

abstract class MarketerState extends Equatable {
  const MarketerState();
}

class MarketerLoading extends MarketerState {
  @override
  List<Object?> get props => [];
}

class MarketerReady extends MarketerState {
  final String marketer;
  final bool isMarketer;
  final bool isReady;

  const MarketerReady({this.marketer = "N/A", this.isMarketer = false, this.isReady = false});

  @override
  List<Object> get props => [marketer, isMarketer];
}

class MarketerWaitingState extends MarketerState {
  @override
  List<Object?> get props => [];
}

class MarketerFinishedState extends MarketerState {
  @override
  List<Object?> get props => [];
}

class MarketerErrorState extends MarketerState {
  final String marketer;
  final bool isMarketer;
  final String error;

  const MarketerErrorState(
      {this.marketer = "N/A", this.isMarketer = false, required this.error});

  @override
  List<Object?> get props => [marketer, isMarketer, error];
}
