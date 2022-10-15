import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/theme.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Icon(
        Icons.check_circle,
        size: 64,
        color: AppColors.green,
      ),
      content: Text(
        "Invite successfully",
        style: GoogleFonts.signika(
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
