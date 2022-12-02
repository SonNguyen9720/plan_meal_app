import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_group_event.dart';
part 'add_group_state.dart';

class AddGroupBloc extends Bloc<AddGroupEvent, AddGroupState> {
  final GroupRepository groupRepository;

  AddGroupBloc({required this.groupRepository}) : super(const AddGroupInitial()) {
    on<NameGroupSubmitEvent>(_onNameGroupSubmitEvent);
  }

  void _onNameGroupSubmitEvent(
      NameGroupSubmitEvent event, Emitter<AddGroupState> emit) async {
    try {
      if (event.name.isEmpty || event.password.isEmpty) {
        emit(const AddGroupValidateFailed(error: "Empty field input"));
      }
      emit(AddGroupProgressing());
      var prefs = await SharedPreferences.getInstance();
      String name = event.name;
      String password = event.password;

      Map<String, dynamic> result = await groupRepository.createGroup(name: name, password: password);
      String groupId = result["id"].toString();
      String groupName = result["name"];
      await prefs.setString("groupId", groupId);
      await prefs.setString("groupName", groupName);
      emit(AddGroupSubmitted(groupName: event.name, password: event.password));
    } catch (exception) {
      emit(AddGroupFailed(error: exception.toString()));
    }
  }
}
