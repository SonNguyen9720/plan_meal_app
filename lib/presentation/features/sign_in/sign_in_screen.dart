import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, signInState) {},
      builder: (context, signInState) {
        return Column(
          children: const [
            Text("Sign in"),
          ],
        );
      },
    ));
  }
}
