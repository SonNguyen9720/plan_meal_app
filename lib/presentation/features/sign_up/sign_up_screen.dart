import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/domain/validator.dart';
import 'package:plan_meal_app/presentation/features/sign_up/bloc/sign_up_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/input_field.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

class SignUpScreen extends StatefulWidget {
  final User user;
  const SignUpScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final GlobalKey<InputFieldState> emailKey = GlobalKey();
  final GlobalKey<InputFieldState> passwordKey = GlobalKey();
  final GlobalKey<InputFieldState> rePasswordKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, signUpState) async {
          if (signUpState is SignUpFinished) {
            await EasyLoading.dismiss();
            Navigator.of(context).pushNamed(PlanMealRoutes.home);
          }
          if (signUpState is SignUpProcessing) {
            EasyLoading.show(
              status: "Loading ...",
              maskType: EasyLoadingMaskType.black,
            );
          }
          if (signUpState is SignUpError) {
            await EasyLoading.dismiss();
            showDialog(context: context, builder: (context) => AlertDialog(title: Text(signUpState.error),));
          }
        },
        builder: (context, signUpState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 3,
                child: Text(
                  "Sign up",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                    height: 1.5,
                  ),
                ),
              ),
              Flexible(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputField(
                      key: emailKey,
                      controller: emailController,
                      icon: Icons.email,
                      hint: "Input your email",
                      validator: Validator.checkEmail,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputField(
                      key: passwordKey,
                      controller: passwordController,
                      icon: Icons.password,
                      hint: "Input your password",
                      isPassword: true,
                      validator: Validator.checkPasswordCorrect,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputField(
                      key: rePasswordKey,
                      controller: rePasswordController,
                      icon: Icons.password,
                      hint: "Confirm your password",
                      isPassword: true,
                      validator: (value) => Validator.checkSecondInputPassword(
                          passwordController.text, rePasswordController.text),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: NavigateButton(
                          text: "Sign up", callbackFunc: _validateAndSend),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _validateAndSend() {
    if (emailKey.currentState!.validate().isNotEmpty) {
      return;
    }
    if (passwordKey.currentState!.validate().isNotEmpty) {
      return;
    }
    if (rePasswordKey.currentState!.validate().isNotEmpty) {
      return;
    }
    BlocProvider.of<SignUpBloc>(context).add(
      SignUpPressed(
          email: emailController.text, password: passwordController.text, user: widget.user),
    );
  }
}
