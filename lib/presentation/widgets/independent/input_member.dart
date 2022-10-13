import 'package:flutter/material.dart';

class InputMember extends StatefulWidget {
  const InputMember({Key? key, required this.textEditingController})
      : super(key: key);
  final TextEditingController textEditingController;

  @override
  State<InputMember> createState() => _InputMemberState();
}

class _InputMemberState extends State<InputMember> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "email",
        ),
      ),
    );
  }
}
