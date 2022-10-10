import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key, required this.user}) : super(key: key);

  final User user;
  final String appbarImage = "assets/onboarding/appbar_pic.svg";
  final String privacyImage = "assets/onboarding/lock2fill.svg";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            appbarImage,
            width: width,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome to a healthier life " + user.name,
                  style: GoogleFonts.signika(
                    fontSize: 32,
                  ),
                  textAlign: TextAlign.center,
                ),
                SvgPicture.asset(privacyImage),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Your privacy is very important to us. "
                    "We guarantee your data will be kept securely and encrypted. "
                    "This way, you can fully concentrate on your goals.",
                    style: GoogleFonts.signika(
                      fontSize: 20,
                      height: 2,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: NavigateButton(
                text: "Next",
                callbackFunc: () {
                  navigateFunc(context, user);
                }),
          ),
        ],
      )),
    );
  }

  void navigateFunc(BuildContext context, User user) {
    Navigator.of(context)
        .pushNamed(PlanMealRoutes.informationUserGoal, arguments: user);
  }
}
