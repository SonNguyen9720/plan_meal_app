part of 'add_group_bloc.dart';

abstract class AddGroupState extends Equatable {
  const AddGroupState();

  @override
  List<Object> get props => [];
}

class AddGroupInitial extends AddGroupState {}

class AddGroupSubmit extends AddGroupState {}
