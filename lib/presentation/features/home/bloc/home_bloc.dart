import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  HomeBloc({required this.userRepository}) : super(HomeLoading()) {
    on<HomeGetUserEvent>(_onHomeGetUserEvent);
  }

  void _onHomeGetUserEvent(HomeGetUserEvent event, Emitter<HomeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    var result = await userRepository.getUser();
    String groupId = result.groupId ?? "";
    String email = result.email ?? "";
    String firstName = result.firstName ?? "";
    String lastName = result.lastName ?? "";
    String name = firstName + " " + lastName;
    await prefs.setString("groupId", groupId);
    await prefs.setString("email", email);
    await prefs.setString("name", name);
    emit(HomeInitial());
  }
}
