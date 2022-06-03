import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/model/intro.dart';

class OnboardScreen extends StatelessWidget {
  OnboardScreen({Key? key}) : super(key: key);

  List<Intro> introList = [
    const Intro("Eat Healthy", "desc 1",
        NetworkImage('https://picsum.photos/250?image=9')),
    const Intro("Healthy Recipes", "desc 2",
        NetworkImage('https://picsum.photos/250?image=9')),
    const Intro("Track your health", "desc 3",
        NetworkImage('https://picsum.photos/250?image=9')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 86,
          ),
          const Center(
            child: Text(
              "Happy Meal",
              style: TextStyle(
                color: AppColors.green,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 72,
              width: 290,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.green),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)))),
                onPressed: () {},
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "All ready have account? ",
                style: TextStyle(
                    color: AppColors.gray,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text("Log in",
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }

  // Widget buildIntroduction(BuildContext context) {
  //   return Container(
  //     child: Center(
  //       child: CarouselSlider.builder(
  //           itemCount: 3,
  //           itemBuilder: (context, index, realIndex) {},
  //           options: CarouselOptions(
  //             autoPlay: true,
  //             autoPlayInterval: const Duration(seconds: 3),
  //           )),
  //     ),
  //   );
  // }

  Widget buildIntroContent(Intro intro) {
    return Center(
      child: Column(
        children: [
          Image(image: intro.image),
          Text(
            intro.introTitle,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          Text(
            intro.desc,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
