import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/profile/change_password/bloc/change_password_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/password_form_field.dart';

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
    final TextEditingController confirmPasswordController =
        TextEditingController();

    var formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change password",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) async {
          if (state is ChangePasswordWaiting) {
            EasyLoading.show(
              status: "Loading ...",
              maskType: EasyLoadingMaskType.black,
            );
          } else if (state is ChangePasswordFinished) {
            await EasyLoading.dismiss();
          } else if (state is ChangePasswordSuccess) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Change password success"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(PlanMealRoutes.profile),
                          child: const Text("OK"))
                    ],
                  );
                });
          } else if (state is ChangePasswordFailed) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Change password failed"),
                    content: Text(state.message),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("OK"))
                    ],
                  );
                });
          }
        },
        child: Form(
          key: formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                PasswordFormField(
                  label: "Old password",
                  textEditingController: passwordController,
                ),
                PasswordFormField(
                  label: "New password",
                  textEditingController: newPasswordController,
                ),
                PasswordFormField(
                  label: "Confirm new password",
                  textEditingController: confirmPasswordController,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: const BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: TextButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<ChangePasswordBloc>(context).add(
                          ChangePasswordSendPassword(
                              oldPassword: passwordController.text,
                              newPassword: confirmPasswordController.text));
                    }
                  },
                  child: const Text(
                    "Update",
                    style: TextStyle(
                      fontSize: 28,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
