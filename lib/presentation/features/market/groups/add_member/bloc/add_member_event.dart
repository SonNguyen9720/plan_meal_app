part of 'add_member_bloc.dart';

abstract class AddMemberEvent extends Equatable {
  const AddMemberEvent();

  @override
  List<Object> get props => [];
}

class SendInvitationToMemberEvent extends AddMemberEvent {
  final String groupId;
  final String email;

  const SendInvitationToMemberEvent({required this.groupId, required this.email});
}
