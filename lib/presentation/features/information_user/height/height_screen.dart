import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/presentation/features/information_user/height/cubit/height_cubit.dart';
import 'package:plan_meal_app/presentation/widgets/independent/linear_progess.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();
  late AnimationController animationController;
  late Animation animation;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animation =
        Tween<double>(begin: 120.0, end: 30.0).animate(animationController)
          ..addListener(() {
            setState(() {});
          });

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        print("Text controller: Focus");
        animationController.forward();
      } else {
        print("Text controller: Unfocus");
        animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child:
            BlocConsumer<HeightCubit, HeightState>(builder: (context, state) {
          return Column(
            children: [
              const LinearProgress(value: 1 / 9),
              Text(
                "What's your goal height?",
                style: GoogleFonts.signika(fontSize: 32),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: animation.value,
              ),
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: "180",
                  hintStyle: GoogleFonts.signika(
                    fontSize: 40,
                  ),
                ),
                textAlign: TextAlign.center,
                style: GoogleFonts.signika(
                  fontSize: 40,
                ),
                focusNode: focusNode,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: NavigateButton(
                        text: "Next",
                        callbackFunc: () => navigatorFunc(widget.user)),
                  ),
                ),
              )
            ],
          );
        }, listener: (context, state) {
          if (state is HeightStored) {
            Navigator.of(context).pushNamed(
                PlanMealRoutes.informationUserActivityIntensity,
                arguments: state.user);
          }
        }),
      ),
    );
  }

  void navigatorFunc(User user) {
    if (textEditingController.text.isNotEmpty) {
      BlocProvider.of<HeightCubit>(context).onNavigationButtonPressed(
          int.parse(textEditingController.text), user);
    }
  }
}
