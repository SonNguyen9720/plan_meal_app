import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:plan_meal_app/config/notification_service.dart';
import 'package:plan_meal_app/config/push_notification_service.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/repositories/abstract/firebase_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/food_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/ingredient_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/measurement_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/menu_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';
import 'package:plan_meal_app/locator.dart';
import 'package:plan_meal_app/presentation/features/add_shopping_list/add_shopping_list_screen.dart';
import 'package:plan_meal_app/presentation/features/authentication/authentication.dart';
import 'package:plan_meal_app/presentation/features/food/add_food_meal/add_sl_to_dish/add_sl_to_dish_screen.dart';
import 'package:plan_meal_app/presentation/features/food/add_food_meal/add_sl_to_dish/bloc/add_sl_to_dish_bloc.dart';
import 'package:plan_meal_app/presentation/features/food_rating/bloc/food_rating_bloc.dart';
import 'package:plan_meal_app/presentation/features/food_rating/food_rating_screen.dart';
import 'package:plan_meal_app/presentation/features/home/bloc/home_bloc.dart';
import 'package:plan_meal_app/presentation/features/home/bmi_bloc/bmi_bloc.dart';
import 'package:plan_meal_app/presentation/features/home/home_screen.dart';
import 'package:plan_meal_app/presentation/features/home/weight_cubit/weight_cubit.dart';
import 'package:plan_meal_app/presentation/features/information_user/name/cubit/user_name_cubit.dart';
import 'package:plan_meal_app/presentation/features/information_user/name/user_name_screen.dart';
import 'package:plan_meal_app/presentation/features/market/groups/add_group/add_group_screen.dart';
import 'package:plan_meal_app/presentation/features/market/groups/add_group/bloc/add_group_bloc.dart';
import 'package:plan_meal_app/presentation/features/market/market_screen.dart';
import 'package:plan_meal_app/presentation/features/onboard/onboard_screen.dart';
import 'package:plan_meal_app/presentation/features/plan_meal/plan_meal_screen.dart';
import 'package:plan_meal_app/presentation/features/profile/change_password/bloc/change_password_bloc.dart';
import 'package:plan_meal_app/presentation/features/profile/change_password/change_password_screen.dart';
import 'package:plan_meal_app/presentation/features/profile/profile_screen.dart';
import 'package:plan_meal_app/presentation/features/profile/update_goal/bloc/update_goal_bloc.dart';
import 'package:plan_meal_app/presentation/features/profile/update_goal/update_goal_screen.dart';
import 'package:plan_meal_app/presentation/features/profile/update_infomation/update_information_screen.dart';
import 'package:plan_meal_app/presentation/features/sign_in/sign_in.dart';
import 'package:plan_meal_app/presentation/features/splashscreen/splash_screen_screen.dart';
import 'package:plan_meal_app/presentation/features/temporatory_market_screen/market_temp_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'locator.dart' as service_locator;
import 'presentation/features/profile/bloc/profile_bloc.dart';
import 'presentation/features/profile/update_infomation/bloc/update_information_bloc.dart';
import 'presentation/features/sign_in/sign_in.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.green
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.green
    ..textColor = Colors.black
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  if (kDebugMode) {
    print("Handling background message : ${remoteMessage.messageId}");
  }
}

void main() async {
  service_locator.init();
  configLoading();
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  await Firebase.initializeApp();
  await NotificationService().init();
  await PushNotificationService.init();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  Bloc.observer = SimpleBlocDelegate();
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) => AuthenticationBloc(),
    child: MultiRepositoryProvider(providers: [
      RepositoryProvider<UserRepository>(create: (context) => sl()),
      RepositoryProvider<GroupRepository>(create: (context) => sl()),
      RepositoryProvider<FoodRepository>(create: (context) => sl()),
      RepositoryProvider<MenuRepository>(create: (context) => sl()),
      RepositoryProvider<FirebaseFireStoreRepository>(
          create: (context) => sl()),
      RepositoryProvider<ShoppingListRepository>(create: (context) => sl()),
      RepositoryProvider<IngredientRepository>(create: (context) => sl()),
      RepositoryProvider<MeasurementRepository>(create: (context) => sl()),
    ], child: const OpenPlanningMealApp()),
  ));
}

class OpenPlanningMealApp extends StatelessWidget {
  const OpenPlanningMealApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        onGenerateRoute: Routers.generateRoute,
        title: 'Happy Meal',
        routes: _registerRoutes(),
        theme: PlanMealAppTheme.of(context),
        useInheritedMediaQuery: true,
        builder: EasyLoading.init(),
      ),
    );
  }

  void registerNotification() async {}

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      PlanMealRoutes.splashScreen: (context) => const SplashScreen(),
      PlanMealRoutes.onboard: (context) => const OnboardScreen(),
      PlanMealRoutes.home: (context) => _buildHome(),
      PlanMealRoutes.plan: (context) => _buildPlanMeal(),
      PlanMealRoutes.market: (context) => const MarketScreen(),
      PlanMealRoutes.profile: (context) => _buildProfile(),
      PlanMealRoutes.informationUserName: (context) => _buildUserNameBloc(),
      PlanMealRoutes.signIn: (context) => _buildSignInBloc(),
      PlanMealRoutes.addGroup: (context) => _buildAddGroupBloc(),
      PlanMealRoutes.updateGoal: (context) => _buildUpdateGoal(),
      PlanMealRoutes.updateInfo: (context) => _buildUpdateInfo(),
      PlanMealRoutes.changePassword: (context) => _buildChangePassword(),
      PlanMealRoutes.foodRating: (context) => _buildFoodRatingScreen(),
      PlanMealRoutes.tempMarket: (context) => const MarketTempScreen(),
      PlanMealRoutes.addShoppingList: (context) =>
          const AddShoppingListScreen(),
      PlanMealRoutes.foodAddSL: (context) => _buildAddSlToDish(),
      // PlanMealRoutes.informationUserExclusiveIngredient: (context) =>
      //     const ExclusiveIngredientScreen(),
    };
  }

  BlocProvider<SignInBloc> _buildSignInBloc() {
    return BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      ),
      child: const SignInScreen(),
    );
  }

  BlocProvider<UserNameCubit> _buildUserNameBloc() {
    return BlocProvider<UserNameCubit>(
      create: (context) => UserNameCubit(),
      child: const NameScreen(),
    );
  }

  BlocProvider<AddGroupBloc> _buildAddGroupBloc() {
    return BlocProvider<AddGroupBloc>(
      create: (context) => AddGroupBloc(
        groupRepository: RepositoryProvider.of<GroupRepository>(context),
      ),
      child: const AddGroupScreen(),
    );
  }

  Widget _buildPlanMeal() {
    return const PlanMealScreen();
  }

  MultiBlocProvider _buildHome() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context))
            ..add(HomeGetUserOverviewEvent(dateTime: DateTime.now())),
        ),
        BlocProvider(
          create: (context) => BmiBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context))
            ..add(BmiLoadEvent()),
        ),
        BlocProvider(
            create: (context) => WeightCubit(
                userRepository: RepositoryProvider.of<UserRepository>(context))
              ..loadWeight(DateTime.now().subtract(const Duration(days: 28)),
                  DateTime.now())),
      ],
      child: const HomeScreen(),
    );
  }

  BlocProvider<UpdateGoalBloc> _buildUpdateGoal() {
    return BlocProvider(
      create: (context) => UpdateGoalBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context))
        ..add(UpdateGoalLoadEvent()),
      child: const UpdateGoalScreen(),
    );
  }

  BlocProvider<UpdateInformationBloc> _buildUpdateInfo() {
    return BlocProvider(
      create: (context) => UpdateInformationBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
      ),
      child: const UpdateInformationScreen(),
    );
  }

  BlocProvider<ProfileBloc> _buildProfile() {
    return BlocProvider(
      create: (context) => ProfileBloc(
          groupRepository: RepositoryProvider.of<GroupRepository>(context))
        ..add(ProfileLoadGroupEvent()),
      child: const ProfileScreen(),
    );
  }

  BlocProvider<ChangePasswordBloc> _buildChangePassword() {
    return BlocProvider(
      create: (context) => ChangePasswordBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
      ),
      child: const ChangePasswordScreen(),
    );
  }

  BlocProvider<AddSlToDishBloc> _buildAddSlToDish() {
    return BlocProvider(
      create: (context) => AddSlToDishBloc(
          shoppingListRepository:
              RepositoryProvider.of<ShoppingListRepository>(context))
        ..add(AddSlToDishLoadSlEvent()),
      child: const AddSlToDishScreen(),
    );
  }

  BlocProvider<FoodRatingBloc> _buildFoodRatingScreen() {
    return BlocProvider(
        create: (context) => FoodRatingBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context))..add(FoodRatingLoadFood()),
      child: const FoodRatingScreen(),
    );
  }
}
