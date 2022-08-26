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
              buildButton(context, "On-boarding", PlanMealRoutes.onboard),
              buildButton(context, "Information User",
                  PlanMealRoutes.informationUserName),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            PlanMealRoutes.informationUserPrivacy,
                            arguments: "Sơn");
                      },
                      child: const Text(
                        "Privacy User",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          PlanMealRoutes.informationUserGoal,
                        );
                      },
                      child: const Text(
                        "Goal Screen",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildButton(BuildContext context, String name, String routeName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.blue,
        child: TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(routeName);
            },
            child: Text(
              name,
              style: const TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
