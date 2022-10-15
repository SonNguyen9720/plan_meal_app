import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_member_event.dart';
part 'add_member_state.dart';

class AddMemberBloc extends Bloc<AddMemberEvent, AddMemberState> {
  AddMemberBloc() : super(AddMemberInitial()) {
    on<SendInvitationToMemberEvent>(_onSendInvitationToMemberEvent);
  }

  void _onSendInvitationToMemberEvent(
      SendInvitationToMemberEvent event, Emitter<AddMemberState> emit) {
    emit(AddMemberProcessing());
    emit(AddMemberSuccess());
    emit(AddMemberInitial());
  }
}
