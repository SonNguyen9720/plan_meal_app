import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/information_user/name/user_name_screen.dart';
import 'package:plan_meal_app/presentation/features/onboard/onboard_screen.dart';
import 'package:plan_meal_app/presentation/features/splashscreen/splash_screen_screen.dart';

import 'locator.dart' as service_locator;

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

void main() async {
  // await service_locator.init();

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocDelegate();
  runApp(OpenPlanningMealApp());
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
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
    );
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      PlanMealRoutes.splashScreen: (context) => SplashScreen(),
      PlanMealRoutes.onboard: (context) => OnboardScreen(),
      PlanMealRoutes.informationUserName: (context) => NameScreen(),
    };
  }
}
