import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 40),
                child: const FractionallySizedBox(
                  widthFactor: 0.8,
                  child: LinearProgressIndicator(
                    value: 1 / 9,
                    color: AppColors.green,
                    backgroundColor: AppColors.backgroundIndicator,
                  ),
                ),
              ),
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
                    controller: textEditingController,
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
    print("On tap");
  }
}
