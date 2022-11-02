import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/domain/validator.dart';
import 'package:plan_meal_app/presentation/widgets/independent/input_field.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';
import 'sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<InputFieldState> emailKey = GlobalKey();
  final GlobalKey<InputFieldState> passwordKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        body: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, signInState) async {
            if (signInState is SignInFinishedState) {
              print("Log in success");
              await EasyLoading.dismiss();
            }
            if (signInState is SignInProcessingState) {
              EasyLoading.show(
                status: "Loading ...",
                maskType: EasyLoadingMaskType.black,
              );
            }
            if (signInState is SignInErrorState) {
              await EasyLoading.dismiss();
              showDialog(context: context, builder: (context) => AlertDialog(title: Text(signInState.error),));
            }
          },
          builder: (context, signInState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 3,
                  child: Text(
                    "Sign in",
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: NavigateButton(
                            text: "Sign in", callbackFunc: _validateAndSend),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }

  void _validateAndSend() {
    if (emailKey.currentState!.validate().isNotEmpty) {
      return;
    }
    if (passwordKey.currentState!.validate().isNotEmpty) {
      return;
    }
    BlocProvider.of<SignInBloc>(context).add(
      SignInPressed(
          email: emailController.text, password: passwordController.text),
    );
  }
}
