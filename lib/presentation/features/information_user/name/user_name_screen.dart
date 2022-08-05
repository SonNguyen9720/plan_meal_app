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
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            const LinearProgressIndicator(
              value: 1 / 9,
              color: AppColors.green,
              backgroundColor: AppColors.backgroundIndicator,
            ),
            Text(
              "What is your name?",
              style: GoogleFonts.signika(fontSize: 32),
            ),
            const Icon(
              Icons.account_circle_sharp,
              size: 150,
              color: AppColors.green,
            ),
            TextField(
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
            NavigateButton(text: "Next", callbackFunc: navigatorFunc)
          ],
        ),
      ),
    );
  }

  void navigatorFunc() {
    print("On tap");
  }
}
