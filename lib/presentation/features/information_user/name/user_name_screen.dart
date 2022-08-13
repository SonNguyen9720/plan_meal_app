import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/widgets/independent/linear_progess.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LinearProgress(value: 1/9),
              Text(
                "What is your name?",
                style: GoogleFonts.signika(fontSize: 32),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Icon(
                  Icons.account_circle_sharp,
                  size: 150,
                  color: AppColors.green,
                ),
              ),
              Expanded(
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Your name",
                      hintStyle: GoogleFonts.signika(
                        fontSize: 40,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.signika(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child:
                    NavigateButton(text: "Next", callbackFunc: navigatorFunc),
              )
            ],
          ),
        ),
      ),
    );
  }

  void navigatorFunc() {
    Navigator.pushNamed(context, PlanMealRoutes.informationUserPrivacy, arguments: nameController.text);
  }
}
