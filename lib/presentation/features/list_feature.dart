import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/routes.dart';

class ListFeatures extends StatelessWidget {
  const ListFeatures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildButton(context, "On-boarding"),
              buildButton(context, "Information User"),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildButton(BuildContext context, String name) {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(PlanMealRoutes.onboard);
                    },
                    child: Text(
                      name,
                      style: const TextStyle(color: Colors.white),
                    )),
              ),
            );
  }
}
