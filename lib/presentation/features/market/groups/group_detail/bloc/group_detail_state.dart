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

  const GroupDetailHasMember({required this.listMember});
}

class GroupDetailError extends GroupDetailState {
  final String error;

  const GroupDetailError({required this.error});
}
