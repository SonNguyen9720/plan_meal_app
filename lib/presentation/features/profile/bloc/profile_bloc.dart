import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/group.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GroupRepository groupRepository;

  ProfileBloc({required this.groupRepository}) : super(ProfileLoading()) {
    on<ProfileLoadGroupEvent>(_onProfileLoadGroupEvent);
  }

  Future<void> _onProfileLoadGroupEvent(ProfileLoadGroupEvent event, Emitter<ProfileState> emit) async {
    var prefs = await SharedPreferences.getInstance();
    List<GroupUser> listGroup = await groupRepository.getGroup();
    if (listGroup.isNotEmpty) {
      await prefs.setString("groupId", listGroup.first.groupId.toString());
      await prefs.setString("groupName", listGroup.first.group!.name.toString());
    } else {
      await prefs.remove("groupId");
      await prefs.remove("groupName");
    }
    emit(ProfileInitial());
  }
}
