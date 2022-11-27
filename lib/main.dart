import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/repositories/abstract/firebase_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/food_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/ingredient_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/menu_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/locator.dart';
import 'package:plan_meal_app/presentation/features/authentication/authentication.dart';
import 'package:plan_meal_app/presentation/features/food/create_food/bloc/create_food_bloc.dart';
import 'package:plan_meal_app/presentation/features/food/create_food/create_food_screen.dart';
import 'package:plan_meal_app/presentation/features/home/home_screen.dart';
import 'package:plan_meal_app/presentation/features/information_user/name/cubit/user_name_cubit.dart';
import 'package:plan_meal_app/presentation/features/information_user/name/user_name_screen.dart';
import 'package:plan_meal_app/presentation/features/market/groups/add_group/add_group_screen.dart';
import 'package:plan_meal_app/presentation/features/market/groups/add_group/bloc/add_group_bloc.dart';
import 'package:plan_meal_app/presentation/features/market/groups/add_member/add_member_screen.dart';
import 'package:plan_meal_app/presentation/features/market/groups/add_member/bloc/add_member_bloc.dart';
import 'package:plan_meal_app/presentation/features/market/market_screen.dart';
import 'package:plan_meal_app/presentation/features/onboard/onboard_screen.dart';
import 'package:plan_meal_app/presentation/features/plan_meal/bloc/plan_meal_bloc.dart';
import 'package:plan_meal_app/presentation/features/plan_meal/plan_meal_screen.dart';
import 'package:plan_meal_app/presentation/features/profile/profile_screen.dart';
import 'package:plan_meal_app/presentation/features/sign_in/sign_in.dart';
import 'package:plan_meal_app/presentation/features/sign_up/sign_up.dart';
import 'package:plan_meal_app/presentation/features/splashscreen/splash_screen_screen.dart';

import 'locator.dart' as service_locator;
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
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
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

void main() async {
  service_locator.init();
  configLoading();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocDelegate();
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) =>
    AuthenticationBloc()
      ..add(AppStarted()),
    child: MultiRepositoryProvider(providers: [
      RepositoryProvider<UserRepository>(create: (context) => sl()),
      RepositoryProvider<GroupRepository>(create: (context) => sl()),
      RepositoryProvider<FoodRepository>(create: (context) => sl()),
      RepositoryProvider<MenuRepository>(create: (context) => sl()),
      RepositoryProvider<FirebaseFireStoreRepository>(
          create: (context) => sl()),
      RepositoryProvider<ShoppingListRepository>(create: (context) => sl()),
      RepositoryProvider<IngredientRepository>(create: (context) => sl()),
    ], child: OpenPlanningMealApp()),
  ));
}

class OpenPlanningMealApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routers.generateRoute,
      title: 'Happy Meal',
      routes: _registerRoutes(),
      theme: PlanMealAppTheme.of(context),
      useInheritedMediaQuery: true,
      builder: EasyLoading.init(),
    );
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      PlanMealRoutes.splashScreen: (context) => const SplashScreen(),
      PlanMealRoutes.onboard: (context) => const OnboardScreen(),
      PlanMealRoutes.home: (context) => const HomeScreen(),
      PlanMealRoutes.plan: (context) => _buildPlanMeal(),
      PlanMealRoutes.market: (context) => const MarketScreen(),
      PlanMealRoutes.profile: (context) => ProfileScreen(),
      PlanMealRoutes.informationUserName: (context) => _buildUserNameBloc(),
      PlanMealRoutes.signIn: (context) => _buildSignInBloc(),
      PlanMealRoutes.signUp: (context) => _buildSignUpBloc(),
      PlanMealRoutes.addGroup: (context) => _buildAddGroupBloc(),
      PlanMealRoutes.addMember: (context) => _buildAddMember(),
      PlanMealRoutes.createFood: (context) => _buildCreateFood(),
    };
  }

  BlocProvider<SignInBloc> _buildSignInBloc() {
    return BlocProvider<SignInBloc>(
      create: (context) =>
          SignInBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          ),
      child: const SignInScreen(),
    );
  }

  BlocProvider<SignUpBloc> _buildSignUpBloc() {
    return BlocProvider<SignUpBloc>(
      create: (context) =>
          SignUpBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
      child: const SignUpScreen(),
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
      create: (context) =>
          AddGroupBloc(
            groupRepository: RepositoryProvider.of<GroupRepository>(context),
          ),
      child: const AddGroupScreen(),
    );
  }

  BlocProvider<AddMemberBloc> _buildAddMember() {
    return BlocProvider<AddMemberBloc>(
      create: (context) => AddMemberBloc(),
      child: const AddMemberScreen(),
    );
  }

  BlocProvider<PlanMealBloc> _buildPlanMeal() {
    return BlocProvider(
      create: (context) =>
      PlanMealBloc(
          menuRepository: RepositoryProvider.of<MenuRepository>(context)
      )
        ..add(PlanMealLoadData(dateTime: DateTime.now())),
      child: const PlanMealScreen(),
    );
  }

  BlocProvider<CreateFoodBloc> _buildCreateFood() {
    return BlocProvider(create: (context) => CreateFoodBloc(
        foodRepository: RepositoryProvider.of<FoodRepository>(context)),
      child: const CreateFoodScreen(),
    );
  }
}
