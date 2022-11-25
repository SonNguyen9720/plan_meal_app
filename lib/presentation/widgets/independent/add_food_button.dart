import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';

class AddFoodButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddFoodButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: DottedBorder(
          color: AppColors.green,
          radius: const Radius.circular(16),
          borderType: BorderType.RRect,
          padding: EdgeInsets.zero,
          dashPattern: const [8, 2],
          strokeWidth: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: const Center(
              child: SizedBox(
                height: 90,
                width: 280,
                child: Icon(Icons.add, color: AppColors.green,),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
