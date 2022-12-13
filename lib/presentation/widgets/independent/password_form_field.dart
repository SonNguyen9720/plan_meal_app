import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';

class PasswordFormField extends StatefulWidget {
  final String label;
  final TextEditingController? textEditingController;
  const PasswordFormField(
      {Key? key, required this.label, this.textEditingController})
      : super(key: key);

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  late bool isSecure;

  @override
  void initState() {
    isSecure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            controller: widget.textEditingController,
            obscureText: isSecure,
            decoration: InputDecoration(
              filled: true,
              labelText: widget.label,
              labelStyle: const TextStyle(color: AppColors.green),
              fillColor: AppColors.greenPastel,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.green),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.green),
              ),
            ),
          ),
        ),
        Positioned(
          right: 15.0,
          bottom: 18.0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isSecure = !isSecure;
              });
            },
            child: isSecure
                ? const Icon(
                    Icons.visibility,
                    color: AppColors.green,
                  )
                : const Icon(
                    Icons.visibility_off,
                    color: AppColors.green,
                  ),
          ),
        ),
      ],
    );
  }
}
