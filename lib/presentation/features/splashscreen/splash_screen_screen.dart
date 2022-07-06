import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
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

  BlocProvider<SplashScreenBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashScreenBloc(Initial()),
      child: BlocListener<SplashScreenBloc, SplashScreenState>(
        listener: (context, state) {
          if (state is Loaded) {
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //     PlanMealRoutes.onboard, (Route<dynamic> route) => false);
            Navigator.of(context).pushNamed(PlanMealRoutes.listFeature);
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
    _dispatchEvent(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
