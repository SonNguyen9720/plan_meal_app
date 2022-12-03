import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/user_overview_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;

  HomeBloc({required this.userRepository}) : super(HomeLoading()) {
    on<HomeGetUserEvent>(_onHomeGetUserEvent);
    on<HomeGetUserOverviewEvent>(_onHomeGetUserOverviewEvent);
  }

  void _onHomeGetUserEvent(
      HomeGetUserEvent event, Emitter<HomeState> emit) async {
  }

  Future<void> _onHomeGetUserOverviewEvent(
      HomeGetUserOverviewEvent event, Emitter<HomeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    var userResult = await userRepository.getUser();
    String groupId = userResult.groupId ?? "";
    String email = userResult.email ?? "";
    String firstName = userResult.firstName ?? "";
    String lastName = userResult.lastName ?? "";
    String name = firstName + " " + lastName;
    String groupName = userResult.group?.name ?? "";
    String weight = userResult.weight.toString();
    String goalWeight = userResult.desiredWeight.toString();
    await prefs.setString("groupId", groupId);
    await prefs.setString("email", email);
    await prefs.setString("name", name);
    await prefs.setString("groupName", groupName);
    await prefs.setString("weight", weight);
    await prefs.setString("goalWeight", goalWeight);
    emit(const HomeInitial());
    String date = DateTimeUtils.parseDateTime(event.dateTime);
    var result = await userRepository.getOverview(date);
    var userOverview = UserOverviewEntity(
        baseCalories: result.baseCalories,
        currentCalories: result.currentCalories,
        totalCalories: result.totalCalories,
        protein: result.protein,
        fat: result.fat,
        carb: result.carb,
    );
    emit(HomeInitial(userOverviewEntity: userOverview));
  }
}
