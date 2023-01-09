import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/group_member.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:plan_meal_app/domain/entities/member_entity.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'group_detail_event.dart';

part 'group_detail_state.dart';

class GroupDetailBloc extends Bloc<GroupDetailEvent, GroupDetailState> {
  final GroupRepository groupRepository;

  GroupDetailBloc({required this.groupRepository})
      : super(GroupDetailInitial()) {
    on<GroupDetailLoadDataEvent>(_onGroupDetailLoadDataEvent);
    on<GroupDetailRemoveMemberEvent>(_onGroupDetailRemoveMemberEvent);
    on<GroupDetailDeleteGroupEvent>(_onGroupDetailDeleteGroupEvent);
  }

  void _onGroupDetailLoadDataEvent(
      GroupDetailLoadDataEvent event, Emitter<GroupDetailState> emit) async {
    try {
      emit(GroupDetailLoading());
      List<GroupMember> groupMemberList =
          await groupRepository.getMemberListByGroupId(groupId: event.groupId);
      int userId = int.parse(PreferenceUtils.getString("userId") ?? "-1");
      List<MemberEntity> memberEntityList = [];
      for (var member in groupMemberList) {
        var user = member.user;
        var name = (user?.account?.firstName ?? "") + " " + (user?.account?.lastName ?? "");
        var isAdmin = false;
        if (member.role == "admin") {
          isAdmin = true;
        }
        var imageUrl = user?.account?.imageUrl ?? "";
        var memberEntity = MemberEntity(
            id: member.groupId.toString(),
            name: name,
            email: user?.account?.email ?? "",
            isAdmin: isAdmin,
            userId: member.userId ?? 0,
          imageUrl: imageUrl
        );
        memberEntityList.add(memberEntity);
      }
      var memberResult = memberEntityList.firstWhere((element) => element.userId == userId);
      emit(GroupDetailHasMember(listMember: memberEntityList, isAdmin: memberResult.isAdmin));
    } catch (exception) {
      emit(GroupDetailError(error: exception.toString()));
    }
  }

  Future<void> _onGroupDetailRemoveMemberEvent(
      GroupDetailRemoveMemberEvent event,
      Emitter<GroupDetailState> emit) async {
    emit(GroupDetailWaiting());
    if (event.isAdmin) {
      var result = await groupRepository.removeMember(
          event.memberId.toString(), event.groupId.toString());
      if (result == "201") {
        List<MemberEntity> memberList = [];
        memberList.addAll(event.memberList);
        memberList.removeWhere((element) => element.userId == event.memberId);
        emit(GroupDetailFinished());
        emit(GroupDetailHasMember(listMember: memberList, isAdmin: event.isAdmin));
      }
      emit(GroupDetailHasMember(listMember: event.memberList, isAdmin: event.isAdmin));
    }
  }

  Future<void> _onGroupDetailDeleteGroupEvent(GroupDetailDeleteGroupEvent event, Emitter<GroupDetailState> emit) async {
    String result = await groupRepository.deleteGroup(event.groupId.toString());
    if (result == "200") {
      var prefs = await SharedPreferences.getInstance();
      prefs.remove("groupId");
      prefs.remove("groupName");
      emit(GroupDetailDeleted());
    }
  }
}
