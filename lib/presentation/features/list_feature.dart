import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/data/model/user.dart';

class ListFeatures extends StatelessWidget {
  const ListFeatures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //On-boarding button
              buildButton(context, "On-boarding", PlanMealRoutes.onboard),

              //Information User
              buildButton(context, "Information User",
                  PlanMealRoutes.informationUserName),

              //sign in
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          PlanMealRoutes.signIn,
                        );
                      },
                      child: const Text(
                        "Sign in screen",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),

              //sign up
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          PlanMealRoutes.signUp,
                        );
                      },
                      child: const Text(
                        "Sign up screen",
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
                          PlanMealRoutes.home,
                        );
                      },
                      child: const Text(
                        "Home screen",
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
                            PlanMealRoutes.informationUserHeight,
                            arguments: User());
                      },
                      child: const Text(
                        "Height screen",
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
                          PlanMealRoutes.addGroup,
                        );
                      },
                      child: const Text(
                        "Add group screen",
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
                          PlanMealRoutes.createFood,
                        );
                      },
                      child: const Text(
                        "Create food screen",
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
