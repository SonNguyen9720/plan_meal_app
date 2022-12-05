part of 'group_detail_bloc.dart';

abstract class GroupDetailState extends Equatable {
  const GroupDetailState();

  @override
  List<Object> get props => [];
}

class GroupDetailInitial extends GroupDetailState {}

class GroupDetailLoading extends GroupDetailState {}

class GroupDetailHasMember extends GroupDetailState {
  final List<MemberEntity> listMember;
  final bool isAdmin;

  const GroupDetailHasMember({required this.listMember, required this.isAdmin});
}

class GroupDetailWaiting extends GroupDetailState {}

class GroupDetailFinished extends GroupDetailState {}

class GroupDetailDeleted extends GroupDetailState {}

class GroupDetailError extends GroupDetailState {
  final String error;

  const GroupDetailError({required this.error});
}
