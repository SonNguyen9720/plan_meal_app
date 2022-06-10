import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:plan_meal_app/data/model/carousel_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final List<CarouselItem> carouselItemList = [
    const CarouselItem(
        image: "assets/intro/onboard_1.png",
        title: "Eat Healthy",
        description:
            "Maintaining good health should be the primary focus of everyone."),
    const CarouselItem(
        image: "assets/intro/onboard_2.png",
        title: "Healthy Recipes",
        description:
            "Browse thousands of healthy recipes from all over the world."),
    const CarouselItem(
        image: "assets/intro/onboard_3.png",
        title: "Track Your Health",
        description: "With amazing inbuilt tools you can track your progress.")
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
            child: Center(
              child: Text(
                "Happy Meal",
                style: TextStyle(
                    fontSize: 30,
                    color: AppColors.green,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          CarouselSlider.builder(
              itemCount: carouselItemList.length,
              itemBuilder: (context, index, realIndex) {
                final carouselItem = carouselItemList[index];
                return buildCarouselItem(carouselItem);
              },
              options: CarouselOptions(
                  height: 400,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  viewportFraction: 1,
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index)),

          ),
          buildIndicator(),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: SizedBox(
              height: 72,
              width: 290,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(
                      color: AppColors.darkGray,
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                ),
                GestureDetector(
                  child: const Text(
                    "Log in",
                    style: TextStyle(
                        color: AppColors.green,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // List buildCarouselItemList() {
  Widget buildCarouselItem(CarouselItem carouselItem) {
    return SizedBox(
      width: 282,
      child: Column(
        children: [
          Image.asset(
            carouselItem.image,
            height: 282,
            width: 282,
            fit: BoxFit.cover,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                carouselItem.title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            width: 282,
            child: Center(
              child: Text(
                carouselItem.description,
                style:
                    const TextStyle(fontSize: 17, color: AppColors.lightGray),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: carouselItemList.length,
      effect: const ExpandingDotsEffect(
        activeDotColor: AppColors.orange,
        dotColor: AppColors.orangeLight,
        expansionFactor: 2,
        dotHeight: 10,
        dotWidth: 12,
      ),
    );
  }
}
