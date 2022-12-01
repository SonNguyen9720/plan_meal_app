import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';

part 'add_member_event.dart';
part 'add_member_state.dart';

class AddMemberBloc extends Bloc<AddMemberEvent, AddMemberState> {
  final GroupRepository groupRepository;
  AddMemberBloc({required this.groupRepository}) : super(AddMemberInitial()) {
    on<SendInvitationToMemberEvent>(_onSendInvitationToMemberEvent);
  }

  void _onSendInvitationToMemberEvent(
      SendInvitationToMemberEvent event, Emitter<AddMemberState> emit) {
    emit(AddMemberProcessing());
    emit(AddMemberSuccess());
    emit(AddMemberInitial());
  }
}
