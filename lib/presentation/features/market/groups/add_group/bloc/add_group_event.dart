part of 'add_group_bloc.dart';

abstract class AddGroupEvent extends Equatable {
  const AddGroupEvent();

  @override
  List<Object> get props => [];
}

class NameGroupSubmitEvent extends AddGroupEvent {
  final String name;
  final String password;

  const NameGroupSubmitEvent({required this.name, required this.password});
}
