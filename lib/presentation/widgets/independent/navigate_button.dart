import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/theme.dart';

class NavigateButton extends StatelessWidget {
  const NavigateButton(
      {Key? key, required this.text, required this.callbackFunc})
      : super(key: key);

  final String text;
  final VoidCallback callbackFunc;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      width: 193,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.green),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)))),
        ),
        onPressed: () {
          callbackFunc();
        },
        child: Text(
          text,
          style: GoogleFonts.signika(fontSize: 24, color: AppColors.white),
        ),
      ),
    );
  }
}
