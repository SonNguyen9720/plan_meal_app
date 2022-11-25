//define routes of application

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/data/repositories/abstract/firebase_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/food_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:plan_meal_app/domain/entities/food_search_entity.dart';
import 'package:plan_meal_app/presentation/features/food/add_food_meal/add_food_detail_screen.dart';
import 'package:plan_meal_app/presentation/features/food/add_food_meal/add_food_screen.dart';
import 'package:plan_meal_app/presentation/features/food/add_food_meal/app_bar_cubit/title_cubit.dart';
import 'package:plan_meal_app/presentation/features/food/add_food_meal/bloc/add_food_bloc.dart';
import 'package:plan_meal_app/presentation/features/food/food_detail/bloc/food_detail_bloc.dart';
import 'package:plan_meal_app/presentation/features/food/food_detail/food_detail_screen.dart';
import 'package:plan_meal_app/presentation/features/information_user/activity_intensity/activity_intensity_screen.dart';
import 'package:plan_meal_app/presentation/features/information_user/activity_intensity/bloc/activity_intensity_bloc.dart';
import 'package:plan_meal_app/presentation/features/information_user/birthday/birthday_screen.dart';
import 'package:plan_meal_app/presentation/features/information_user/birthday/cubit/birthday_cubit.dart';
import 'package:plan_meal_app/presentation/features/information_user/current_weight/cubit/current_weight_cubit.dart';
import 'package:plan_meal_app/presentation/features/information_user/current_weight/current_weight_screen.dart';
import 'package:plan_meal_app/presentation/features/information_user/gender/cubit/gender_cubit.dart';
import 'package:plan_meal_app/presentation/features/information_user/gender/gender_screen.dart';
import 'package:plan_meal_app/presentation/features/information_user/goal/bloc/goal_bloc.dart';
import 'package:plan_meal_app/presentation/features/information_user/goal/goal_screen.dart';
import 'package:plan_meal_app/presentation/features/information_user/goal_weight/cubit/goal_weight_cubit.dart';
import 'package:plan_meal_app/presentation/features/information_user/goal_weight/goal_weight_screen.dart';
import 'package:plan_meal_app/presentation/features/information_user/height/cubit/height_cubit.dart';
import 'package:plan_meal_app/presentation/features/information_user/height/height_screen.dart';
import 'package:plan_meal_app/presentation/features/information_user/privacy/privacy_screen.dart';
import 'package:plan_meal_app/presentation/features/ingredient/bloc/ingredient_bloc.dart';
import 'package:plan_meal_app/presentation/features/ingredient/ingredient_screen.dart';
import 'package:plan_meal_app/presentation/features/ingredient_detail/bloc/ingredient_detail_bloc.dart';
import 'package:plan_meal_app/presentation/features/ingredient_detail/ingredient_detail_screen.dart';
import 'package:plan_meal_app/presentation/features/list_feature.dart';
import 'package:plan_meal_app/presentation/features/market/groups/group_detail/bloc/group_detail_bloc.dart';
import 'package:plan_meal_app/presentation/features/market/groups/group_detail/group_detail_screen.dart';
import 'package:plan_meal_app/presentation/features/scan_food/bloc/scan_food_bloc.dart';
import 'package:plan_meal_app/presentation/features/scan_food/scan_food_screen.dart';

class PlanMealRoutes {
  static const splashScreen = '/';
  static const onboard = 'onboard';
  static const listFeature = 'listFeature';
  static const informationUserName = 'informationUserName';
  static const informationUserPrivacy = 'informationUserPrivacy';
  static const informationUserGoal = 'informationUserGoal';
  static const informationUserGender = 'informationUserGender';
  static const informationUserBirthday = 'informationUserBirthday';
  static const informationUserCurrentWeight = 'informationUserCurrentWeight';
  static const informationUserGoalWeight = 'informationUserGoalWeight';
  static const informationUserActivityIntensity =
      'informationUserActivityIntensity';
  static const informationUserHeight = 'informationUserHeight';
  static const signIn = 'signIn';
  static const signUp = 'signUp';

  //main route
  static const home = 'home';
  static const plan = 'plan';
  static const scan = 'scan';
  static const market = 'market';
  static const profile = 'profile';

  //market route
  static const addIngredient = 'addIngredient';
  static const ingredientDetail = 'ingredientDetail';

  //group route
  static const addGroup = 'addGroup';
  static const groupDetail = 'groupDetail';
  static const addMember = 'addMember';

  //food route
  static const addFood = 'addFood';
  static const foodDetail = 'foodDetail';
  static const addFoodDetail = 'addFoodDetail';
  static const createFood = 'createFood';
}

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PlanMealRoutes.listFeature:
        return MaterialPageRoute(builder: (_) => const ListFeatures());
      case PlanMealRoutes.informationUserPrivacy:
        var user = settings.arguments as User;
        return MaterialPageRoute(builder: (_) => PrivacyScreen(user: user));
      case PlanMealRoutes.informationUserGoal:
        var user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<GoalBloc>(
                  create: (context) => GoalBloc(),
                  child: GoalScreen(user: user),
                ));
      case PlanMealRoutes.informationUserGender:
        var user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<GenderCubit>(
                  create: (context) => GenderCubit(),
                  child: GenderScreen(user: user),
                ));
      case PlanMealRoutes.informationUserBirthday:
        var user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<BirthdayCubit>(
                  create: (context) => BirthdayCubit(),
                  child: BirthdayScreen(user: user),
                ));
      case PlanMealRoutes.informationUserCurrentWeight:
        var user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<CurrentWeightCubit>(
                  create: (context) => CurrentWeightCubit(),
                  child: CurrentWeight(user: user),
                ));
      case PlanMealRoutes.informationUserGoalWeight:
        var user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<GoalWeightCubit>(
                  create: (context) => GoalWeightCubit(),
                  child: GoalWeight(user: user),
                ));

      case PlanMealRoutes.ingredientDetail:
        var args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<IngredientDetailBloc>(
                  create: (context) =>
                      IngredientDetailBloc()..add(IngredientDetailLoadEvent()),
                  child: IngredientDetailScreen(
                    ingredientId: args.toString(),
                  ),
                ));

      case PlanMealRoutes.addIngredient:
        var args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<IngredientBloc>(
                  create: (context) => IngredientBloc(),
                  child: const IngredientScreen(
                    ingredientList: [],
                  ),
                ));

      case PlanMealRoutes.informationUserActivityIntensity:
        var user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<ActivityIntensityBloc>(
                  create: (context) => ActivityIntensityBloc(),
                  child: ActivityIntensityScreen(
                    user: user,
                  ),
                ));

      case PlanMealRoutes.informationUserHeight:
        var user = settings.arguments as User;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<HeightCubit>(
                  create: (context) => HeightCubit(),
                  child: HeightScreen(
                    user: user,
                  ),
                ));

      case PlanMealRoutes.groupDetail:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider<GroupDetailBloc>(
                  create: (context) => GroupDetailBloc(
                      groupRepository:
                          RepositoryProvider.of<GroupRepository>(context))
                    ..add(GroupDetailLoadDataEvent(
                        groupId: arguments['groupId'])),
                  child: GroupDetailScreen(
                    groupName: arguments['groupName'],
                    groupId: arguments['groupId'],
                  ),
                ));

      case PlanMealRoutes.scan:
        var cameras = settings.arguments as List<CameraDescription>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ScanFoodBloc(
                    firebaseFireStoreRepository:
                        RepositoryProvider.of<FirebaseFireStoreRepository>(
                            context),
                    foodRepository:
                        RepositoryProvider.of<FoodRepository>(context),
                  ),
                  child: const ScanFoodScreen(),
                ));

      case PlanMealRoutes.addFood:
        var date = settings.arguments as DateTime;
        return MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
                    providers: [
                      BlocProvider<AddFoodBloc>(
                          create: (context) => AddFoodBloc(
                              foodRepository:
                                  RepositoryProvider.of<FoodRepository>(
                                      context))
                            ..add(AddFoodLoadFood(
                                meal: "BREAKFAST", date: date))),
                      BlocProvider<TitleCubit>(
                          create: (context) => TitleCubit())
                    ],
                    child: AddFoodScreen(
                      dateTime: date,
                    )));

      case PlanMealRoutes.foodDetail:
        var dishId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider<FoodDetailBloc>(
                  create: (context) => FoodDetailBloc(
                      foodRepository:
                          RepositoryProvider.of<FoodRepository>(context))
                    ..add(FoodDetailLoadEvent(foodId: dishId)),
                  child: const FoodDetailScreen(),
                ));

      case PlanMealRoutes.addFoodDetail:
        var foodSearchEntity = settings.arguments as FoodSearchEntity;
        return MaterialPageRoute(
            builder: (_) =>
                AddFoodDetailScreen(foodSearchEntity: foodSearchEntity));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text("No route defined for ${settings.name}"),
                  ),
                ));
    }
  }
}
