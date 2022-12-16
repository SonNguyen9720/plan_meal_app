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
      HomeGetUserEvent event, Emitter<HomeState> emit) async {}

  Future<void> _onHomeGetUserOverviewEvent(
      HomeGetUserOverviewEvent event, Emitter<HomeState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var userResult = await userRepository.getUser();
      String userId = userResult.id.toString();
      String groupId = "";
      if (userResult.group != null) {
        groupId = userResult.group!.id.toString();
      }
      String email = userResult.email ?? "";
      String firstName = userResult.firstName ?? "";
      String lastName = userResult.lastName ?? "";
      String name = firstName + " " + lastName;
      String groupName = userResult.group?.name ?? "";
      String weight = userResult.weight.toString();
      String goalWeight = userResult.desiredWeight.toString();
      String imageUrl = userResult.imageUrl ?? "";
      String dob = userResult.dob ?? "";
      String height = userResult.height.toString();
      String age = userResult.age.toString();
      String healthGoal = userResult.healthGoal ?? "";
      String sex = userResult.sex ?? "male";
      String activityIntensity = userResult.activityIntensity ?? "";
      await prefs.setString("firstName", firstName);
      await prefs.setString("lastName", lastName);
      await prefs.setString("userId", userId);
      await prefs.setString("groupId", groupId);
      await prefs.setString("email", email);
      await prefs.setString("name", name);
      await prefs.setString("dob", dob);
      await prefs.setString("height", height);
      await prefs.setString("age", age);
      await prefs.setString("healthGoal", healthGoal);
      await prefs.setString("sex", sex);
      await prefs.setString("activityIntensity", activityIntensity);
      await prefs.setString("groupName", groupName);
      await prefs.setString("weight", weight);
      await prefs.setString("goalWeight", goalWeight);
      await prefs.setString("imageUrl", imageUrl);
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
    } on Exception catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
