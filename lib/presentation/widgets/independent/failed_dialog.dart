import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/theme.dart';

class FailedDialog extends StatelessWidget {
  const FailedDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Icon(
        Icons.error,
        size: 64,
        color: AppColors.red,
      ),
      content: Text(
        "Invite failed. Please try again.",
        style: GoogleFonts.signika(
          fontSize: 20,
        ),
      ),
    );
  }
}
