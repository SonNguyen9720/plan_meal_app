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

class GroupDetailRemoveMemberEvent extends GroupDetailEvent {
  final int groupId;
  final int memberId;
  final List<MemberEntity> memberList;
  final bool isAdmin;

  const GroupDetailRemoveMemberEvent(
      {required this.groupId, required this.memberId, required this.memberList, required this.isAdmin});
}

class GroupDetailDeleteGroupEvent extends GroupDetailEvent {
  final int groupId;

  const GroupDetailDeleteGroupEvent({required this.groupId});
}
