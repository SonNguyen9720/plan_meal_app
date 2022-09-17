import 'package:flutter/material.dart';

class CheckboxTile extends StatefulWidget {
  final IconData iconsData;
  final String title;
  final bool initialValue;
  final ValueChanged<bool?>? onChanged;

  const CheckboxTile(
      {Key? key,
      required this.iconsData,
      required this.title,
      this.initialValue = false,
      required this.onChanged})
      : super(key: key);

  @override
  State<CheckboxTile> createState() => _CheckboxTileState();
}

class _CheckboxTileState extends State<CheckboxTile> {
  late bool isChecked;
  @override
  void initState() {
    // TODO: implement initState
    isChecked = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      leading: Icon(widget.iconsData),
      trailing: Checkbox(
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
