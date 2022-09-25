import 'package:flutter/material.dart';

class SpecificDietScreen extends StatefulWidget {
  const SpecificDietScreen({Key? key}) : super(key: key);

  @override
  State<SpecificDietScreen> createState() => _SpecificDietScreenState();
}

class _SpecificDietScreenState extends State<SpecificDietScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Widget is ready"),
      ),
    );
  }
}
