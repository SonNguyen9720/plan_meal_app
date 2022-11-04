import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/group.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:plan_meal_app/domain/entities/group_user_enity.dart';

part 'groups_event.dart';

part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final GroupRepository groupRepository;

  GroupsBloc({required this.groupRepository}) : super(GroupsInitial()) {
    on<GroupsLoadingEvent>(_onGroupsLoadingEvent);
  }

  Future<void> _onGroupsLoadingEvent(
      GroupsEvent event, Emitter<GroupsState> emit) async {
    emit(GroupsLoading());
    List<GroupUser> groupUserModelList = await groupRepository.getGroup();
    List<GroupUserEntity> groupUserEntityList = [];
    for (var groupUser in groupUserModelList) {
      var groupUserEntity = GroupUserEntity(
          groupName: groupUser.group?.name ?? "",
          groupId: groupUser.groupId ?? 0);
      groupUserEntityList.add(groupUserEntity);
    }
    if (groupUserEntityList.isEmpty) {
      emit(NoGroup());
    } else {
      emit(HaveGroup(groupUserList: groupUserEntityList));
    }
  }
}
