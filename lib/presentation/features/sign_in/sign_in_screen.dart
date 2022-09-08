import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/theme.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        body: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, signInState) {},
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
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          color: AppColors.backgroundInput,
                          child: Row(
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 20),
                                  child: const Icon(
                                    Icons.email,
                                    color: AppColors.green,
                                  )),
                              Expanded(
                                child: TextField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      hintText: "Enter your email",
                                      hintStyle: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          color: AppColors.backgroundInput,
                          child: Row(
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 20),
                                  child: const Icon(
                                    Icons.password,
                                    color: AppColors.green,
                                  )),
                              Expanded(
                                child: TextField(
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Enter your password",
                                    hintStyle: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: NavigateButton(
                              text: "Sign in", callbackFunc: () {}),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
