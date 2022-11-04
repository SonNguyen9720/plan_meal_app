import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/group.dart';
import 'package:plan_meal_app/data/model/group_member.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:plan_meal_app/domain/entities/member_entity.dart';

part 'group_detail_event.dart';

part 'group_detail_state.dart';

class GroupDetailBloc extends Bloc<GroupDetailEvent, GroupDetailState> {
  final GroupRepository groupRepository;

  GroupDetailBloc({required this.groupRepository})
      : super(GroupDetailInitial()) {
    on<GroupDetailLoadDataEvent>(_onGroupDetailLoadDataEvent);
  }

  void _onGroupDetailLoadDataEvent(
      GroupDetailLoadDataEvent event, Emitter<GroupDetailState> emit) async {
    try {
      emit(GroupDetailLoading());
      List<GroupMember> groupMemberList =
      await groupRepository.getMemberListByGroupId(groupId: event.groupId);
      List<MemberEntity> memberEntityList = [];
      for (var member in groupMemberList) {
        var user = member.user;
        var name = (user?.firstName ?? "") + " " + (user?.lastName ?? "");
        var isAdmin = false;
        if (member.role == "admin") {
          isAdmin = true;
        }
        var memberEntity = MemberEntity(
            name: name,
            email: user?.email ?? "",
            isAdmin: isAdmin,
            userId: member.userId ?? 0);
        memberEntityList.add(memberEntity);
      }
      emit(GroupDetailHasMember(listMember: memberEntityList));
    } catch (exception) {
      emit(GroupDetailError(error: exception.toString()));
    }

  }
}
