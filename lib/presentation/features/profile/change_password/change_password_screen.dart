import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    var formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change password", style: TextStyle(fontSize: 20),),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: "Old password",
                  labelStyle: TextStyle(color: AppColors.green),
                  fillColor: AppColors.greenPastel,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.green),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.green),
                  ),
                ),
              ),
              TextFormField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: "New password",
                  labelStyle: TextStyle(color: AppColors.green),
                  fillColor: AppColors.greenPastel,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.green),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.green),
                  ),
                ),
              ),
              TextFormField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: "Confirm new password",
                  labelStyle: TextStyle(color: AppColors.green),
                  fillColor: AppColors.greenPastel,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.green),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.green),
                  ),
                ),
                validator: (String? value) {
                  if (value == null) {
                    return 'This field must not empty';
                  }
                  if (value != newPasswordController.text) {
                    return 'Password is not match';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
