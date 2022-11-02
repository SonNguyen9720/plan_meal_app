import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/group.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final GroupRepository groupRepository;
  GroupsBloc({required this.groupRepository}) : super(GroupsInitial()) {
    on<GroupsLoadingEvent>(_onGroupsLoadingEvent);
  }

  Future<void> _onGroupsLoadingEvent(GroupsEvent event, Emitter<GroupsState> emit) async {
    emit(GroupsLoading());
    List<GroupUser> groupUserModel = await groupRepository.getGroup();
    if (groupUserModel.isEmpty) {
      emit(NoGroup());
    } else {
      emit(HaveGroup());
    }
  }
}
