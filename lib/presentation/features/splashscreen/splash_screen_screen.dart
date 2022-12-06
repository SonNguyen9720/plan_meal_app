import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/authentication/authentication.dart';
import 'package:plan_meal_app/presentation/features/splashscreen/splash_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      body: buildBody(context),
    );
  }

  BlocProvider<AuthenticationBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc()..add(AppStarted()),
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.of(context).pushNamed(PlanMealRoutes.onboard);
          } else if (state is Authenticated) {
            Navigator.of(context).pushNamed(PlanMealRoutes.home);
          }
        },
        child: const SplashScreenWidgetState(),
      ),
    );
  }
}

class SplashScreenWidgetState extends StatefulWidget {
  const SplashScreenWidgetState({Key? key}) : super(key: key);

  @override
  State<SplashScreenWidgetState> createState() =>
      _SplashScreenWidgetStateState();
}

class _SplashScreenWidgetStateState extends State<SplashScreenWidgetState> {
  @override
  void initState() {
    super.initState();
    // _dispatchEvent(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/app_logo.png"),
        Row(
          children: const [
            Expanded(
              child: Text(
                "Happy Meal",
                style: TextStyle(
                  fontSize: 50,
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const Text(
          "Healthy Meal - Happy life",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        )
      ],
    );
  }

  void _dispatchEvent(BuildContext context) {
    BlocProvider.of<SplashScreenBloc>(context)
        .add(NavigationToNextScreenEvent());
  }
}
