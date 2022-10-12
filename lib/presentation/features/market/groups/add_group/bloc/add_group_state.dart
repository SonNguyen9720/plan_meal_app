part of 'add_group_bloc.dart';

abstract class AddGroupState extends Equatable {
  const AddGroupState({required this.groupName, required this.members});
  final String groupName;
  final int members;

  @override
  List<Object> get props => [groupName, members];
}

class AddGroupInitial extends AddGroupState {
  const AddGroupInitial() : super(groupName: "", members: 0);
}

class AddGroupSubmitted extends AddGroupState {
  const AddGroupSubmitted({required String groupName})
      : super(groupName: groupName, members: 0);
}
