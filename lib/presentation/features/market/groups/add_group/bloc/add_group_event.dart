part of 'add_group_bloc.dart';

abstract class AddGroupEvent extends Equatable {
  const AddGroupEvent();

  @override
  List<Object> get props => [];
}

class NameGroupSubmitted extends AddGroupEvent {
  final String name;

  const NameGroupSubmitted({required this.name});
}
