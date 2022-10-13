import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_member_event.dart';
part 'add_member_state.dart';

class AddMemberBloc extends Bloc<AddMemberEvent, AddMemberState> {
  AddMemberBloc() : super(AddMemberInitial()) {
    on<AddMemberEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
