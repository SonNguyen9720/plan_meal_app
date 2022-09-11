import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/theme.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;
  final FormFieldValidator? validator;
  final TextInputType keyboard;
  final FocusNode? focusNode;
  final VoidCallback? onFinished;
  final bool isPassword;
  final Function? onValueChanged;
  final String? error;
  final IconData icon;

  const InputField(
      {Key? key,
      required this.controller,
      this.hint,
      this.validator,
      this.keyboard = TextInputType.text,
      this.focusNode,
      this.onFinished,
      this.isPassword = false,
      this.onValueChanged,
      this.error,
      required this.icon})
      : super(key: key);

  @override
  State<InputField> createState() {
    return InputFieldState();
  }
}

class InputFieldState extends State<InputField> {
  late String error = widget.error != null ? widget.error! : "";
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: error.isNotEmpty
              ? BoxDecoration(
                  border: Border.all(color: AppColors.red),
                  color: AppColors.backgroundInput)
              : const BoxDecoration(color: AppColors.backgroundInput),
          child: Row(
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    widget.icon,
                    color: AppColors.green,
                  )),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  keyboardType: widget.keyboard,
                  obscureText: widget.isPassword,
                  decoration: InputDecoration(
                    hintText: widget.hint != null ? widget.hint! : "",
                    hintStyle: GoogleFonts.inter(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    border: InputBorder.none,
                  ),
                  focusNode: widget.focusNode,
                ),
              ),
            ],
          ),
        ),
        error.isNotEmpty
            ? Text(error,
                style: GoogleFonts.inter(color: AppColors.red, fontSize: 12))
            : const SizedBox.shrink(),
      ],
    );
  }

  String validate() {
    if (widget.validator != null) {
      setState(() {
        error = widget.validator!(widget.controller.text)!;
      });
      return error;
    }
    return "";
  }
}
