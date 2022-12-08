import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';

class RadioTile extends StatelessWidget {
  const RadioTile(
      {Key? key,
      required this.iconsData,
      required this.title,
      this.subTitle,
      this.initialValue = false,
      this.isChecked = false,
      required this.onChange})
      : super(key: key);

  final IconData iconsData;
  final String title;
  final String? subTitle;
  final bool initialValue;
  final bool isChecked;
  final VoidCallback onChange;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChange,
      child: ListTile(
        tileColor: AppColors.backgroundInput,
        title: Text(title),
        subtitle: subTitle != null ? Text(subTitle!) : null,
        leading: Icon(
          iconsData,
          color: AppColors.green,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        trailing: Checkbox(
          shape: const CircleBorder(),
          checkColor: AppColors.white,
          activeColor: AppColors.orangeYellow,
          fillColor: MaterialStateProperty.all(AppColors.orangeYellow),
          value: initialValue,
          onChanged: null,
        ),
      ),
    );
  }
}
