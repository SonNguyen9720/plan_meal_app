import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/presentation/features/food_rating/bloc/food_rating_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/food_rating_tile.dart';

class FoodRatingScreen extends StatelessWidget {
  const FoodRatingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Food rating"),
          ),
          body: BlocBuilder<FoodRatingBloc, FoodRatingState>(
            builder: (context, state) {
              return Column(
                children: [
                  buildDislikedFood(),
                  const Divider(),
                  buildLikedFood(),
                ],
              );
            },
          ),
        ));
  }

  Widget buildLikedFood() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Liked foods",
            style: TextStyle(fontSize: 28),
          ),
          Column(
            children: [
              FoodRatingTile(
                imageUrl:
                "https://firebasestorage.googleapis.com/v0/b/happy-meal-5f5a4.appspot.com/o/images%2Fcom-tam%2Fcom-tam.jpeg2b98779b-9850-402b-aae9-2d6b84c817ab?alt=media&token=4f1af7bc-1cb0-4899-b757-89c6512d1656",
                name: "Cơm tấm",
                onTap: () {},
                isLiked: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDislikedFood() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Disliked foods",
            style: TextStyle(fontSize: 28),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Row(
              children: const [
                Expanded(
                    child: Text(
                      "You haven't disliked any foods",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
