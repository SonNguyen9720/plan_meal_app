import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/presentation/features/information_user/gender/cubit/gender_cubit.dart';
import 'package:plan_meal_app/presentation/widgets/independent/linear_progess.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<GenderCubit, GenderState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              const LinearProgress(value: 1 / 9),
              Text(
                "What is your gender?",
                style: GoogleFonts.signika(fontSize: 32),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: NavigateButton(text: "Next", callbackFunc: () {}),
              ),
            ],
          );
        },
      ),
    );
  }
}
