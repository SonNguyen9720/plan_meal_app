import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';

class CheckboxTile extends StatefulWidget {
  final IconData iconsData;
  final String title;
  final String? subTitle;
  final bool initialValue;
  final ValueChanged<bool?>? onChanged;

  const CheckboxTile(
      {Key? key,
      required this.iconsData,
      required this.title,
      this.initialValue = false,
      required this.onChanged,
      this.subTitle})
      : super(key: key);

  @override
  State<CheckboxTile> createState() => _CheckboxTileState();
}

class _CheckboxTileState extends State<CheckboxTile> {
  late bool isChecked;
  @override
  void initState() {
    isChecked = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColors.backgroundInput,
      title: Text(widget.title),
      subtitle: widget.subTitle != null ? Text(widget.subTitle!) : null,
      leading: Icon(
        widget.iconsData,
        color: AppColors.green,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      trailing: Checkbox(
        shape: const CircleBorder(),
        checkColor: AppColors.white,
        activeColor: AppColors.orange,
        onChanged: (value) {
          setState(() {
            isChecked = value!;
            print("checkboxTile: $value");
            widget.onChanged!(value);
          });
        },
        value: isChecked,
      ),
    );
  }
}
