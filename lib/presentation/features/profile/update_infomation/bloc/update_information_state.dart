part of 'update_information_bloc.dart';

abstract class UpdateInformationState extends Equatable {
  const UpdateInformationState();
}

class UpdateInformationInitial extends UpdateInformationState {
  @override
  List<Object> get props => [];
}

class UpdateInformationWaiting extends UpdateInformationState {
  @override
  List<Object?> get props => [];
}

class UpdateInformationFinished extends UpdateInformationState {
  @override
  List<Object?> get props => [];
}
