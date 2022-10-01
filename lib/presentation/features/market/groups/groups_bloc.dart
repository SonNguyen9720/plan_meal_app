import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  GroupsBloc() : super(GroupsInitial()) {
    on<GroupsLoadingEvent>(_onGroupsLoadingEvent);
  }

  void _onGroupsLoadingEvent(GroupsEvent event, Emitter<GroupsState> emit) {
    emit(GroupsLoading());
    emit(NoGroup());
  }
}
