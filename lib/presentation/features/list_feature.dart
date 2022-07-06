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
              Container(
                color: Colors.grey,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(PlanMealRoutes.onboard);
                    },
                    child: const Text(
                      "Onboard",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
