part of 'group_detail_bloc.dart';

abstract class GroupDetailEvent extends Equatable {
  const GroupDetailEvent();

  @override
  List<Object> get props => [];
}

class GroupDetailLoadDataEvent extends GroupDetailEvent {
  final int groupId;

  const GroupDetailLoadDataEvent({required this.groupId});
}
