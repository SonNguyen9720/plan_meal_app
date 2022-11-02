part of 'add_group_bloc.dart';

abstract class AddGroupState extends Equatable {
  const AddGroupState();

  @override
  List<Object> get props => [];
}

class AddGroupInitial extends AddGroupState {
  const AddGroupInitial() : super();
}

class AddGroupValidateFailed extends AddGroupState {
  final String error;

  const AddGroupValidateFailed({required this.error});
}

class AddGroupFailed extends AddGroupState {
  final String error;

  const AddGroupFailed({required this.error});
}

class AddGroupProgressing extends AddGroupState {}

class AddGroupSubmitted extends AddGroupState {
  final String groupName;
  final String password;

  const AddGroupSubmitted(
      {required this.groupName, required this.password})
      : super();
}
