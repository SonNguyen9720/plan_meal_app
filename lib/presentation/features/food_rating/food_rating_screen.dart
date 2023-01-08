import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/domain/entities/food_rating_entity.dart';
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
          if (state is FoodRatingLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FoodRatingLoaded) {
            return Column(
              children: [
                Expanded(child: buildDislikedFood(context, state)),
                const Divider(),
                Expanded(child: buildLikedFood(context, state)),
              ],
            );
          }
          return Container();
        },
      ),
    ));
  }

  Widget buildLikedFood(BuildContext context, FoodRatingLoaded state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Liked foods",
            style: TextStyle(fontSize: 28),
          ),
          state.favoriteFoodList.isNotEmpty
              ? buildListLikedItem(state.favoriteFoodList)
              : buildNoFoodLiked(),
        ],
      ),
    );
  }

  Widget buildDislikedFood(BuildContext context, FoodRatingLoaded state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Disliked foods",
            style: TextStyle(fontSize: 28),
          ),
          state.dislikedFoodList.isNotEmpty
              ? buildListDislikedItem(state.dislikedFoodList)
              : buildNoFoodDisliked(),
        ],
      ),
    );
  }

  Widget buildListDislikedItem(List<FoodRatingEntity> foodRatingList) {
    return Expanded(
        child: ListView.builder(
      itemCount: foodRatingList.length,
      itemBuilder: (context, index) {
        return FoodRatingTile(
          name: foodRatingList[index].name,
          isDisliked: (foodRatingList[index].isSelected &&
              !foodRatingList[index].isLiked),
          onLike: () {
            //no like and dislike
            if (!foodRatingList[index].isSelected) {
              BlocProvider.of<FoodRatingBloc>(context).add(
                  FoodRatingLikeFoodEvent(
                      foodRatingEntity: foodRatingList[index],
                      dislikedIndex: index));
            }
            //dislike
            if (foodRatingList[index].isSelected &&
                !foodRatingList[index].isLiked) {
              BlocProvider.of<FoodRatingBloc>(context).add(
                  FoodRatingLikeFoodEvent(
                      foodRatingEntity: foodRatingList[index],
                      dislikedIndex: index));
            }

            //like
            if (foodRatingList[index].isSelected &&
                foodRatingList[index].isLiked) {
              BlocProvider.of<FoodRatingBloc>(context)
                  .add(FoodRatingUnLikedFoodEvent(
                foodRatingEntity: foodRatingList[index],
                dislikedIndex: index,
              ));
            }
          },
          onDislike: () {
            //no liked and disliked
            if (!foodRatingList[index].isSelected) {
              BlocProvider.of<FoodRatingBloc>(context).add(
                  FoodRatingDislikedFoodEvent(
                      foodRatingEntity: foodRatingList[index],
                      dislikedIndex: index));
            }
            //liked
            if (foodRatingList[index].isSelected &&
                foodRatingList[index].isLiked) {
              BlocProvider.of<FoodRatingBloc>(context).add(
                  FoodRatingDislikedFoodEvent(
                      foodRatingEntity: foodRatingList[index],
                      dislikedIndex: index));
            }

            //dislike
            if (foodRatingList[index].isSelected &&
                !foodRatingList[index].isLiked) {
              BlocProvider.of<FoodRatingBloc>(context).add(
                  FoodRatingUnDislikedFoodEvent(
                      foodRatingEntity: foodRatingList[index],
                      dislikedIndex: index));
            }
          },
        );
      },
    ));
  }

  Widget buildListLikedItem(List<FoodRatingEntity> foodRatingList) {
    return Expanded(
        child: ListView.builder(
      itemCount: foodRatingList.length,
      itemBuilder: (context, index) {
        return FoodRatingTile(
          name: foodRatingList[index].name,
          isLiked: (foodRatingList[index].isSelected &&
              foodRatingList[index].isLiked),
          onLike: () {
            //no like and dislike
            if (!foodRatingList[index].isSelected) {
              BlocProvider.of<FoodRatingBloc>(context).add(
                  FoodRatingLikeFoodEvent(
                      foodRatingEntity: foodRatingList[index],
                      favoriteIndex: index));
            }
            //dislike
            if (foodRatingList[index].isSelected &&
                !foodRatingList[index].isLiked) {
              BlocProvider.of<FoodRatingBloc>(context).add(
                  FoodRatingLikeFoodEvent(
                      foodRatingEntity: foodRatingList[index],
                      favoriteIndex: index));
            }

            //like
            if (foodRatingList[index].isSelected &&
                foodRatingList[index].isLiked) {
              BlocProvider.of<FoodRatingBloc>(context).add(
                  FoodRatingUnLikedFoodEvent(
                      foodRatingEntity: foodRatingList[index],
                      favoriteIndex: index));
            }
          },
          onDislike: () {
            //no liked and disliked
            if (!foodRatingList[index].isSelected) {
              BlocProvider.of<FoodRatingBloc>(context).add(
                  FoodRatingDislikedFoodEvent(
                      foodRatingEntity: foodRatingList[index],
                      favoriteIndex: index));
            }
            //liked
            if (foodRatingList[index].isSelected &&
                foodRatingList[index].isLiked) {
              BlocProvider.of<FoodRatingBloc>(context).add(
                  FoodRatingDislikedFoodEvent(
                      foodRatingEntity: foodRatingList[index],
                      favoriteIndex: index));
            }

            //disliked
            if (foodRatingList[index].isSelected &&
                !foodRatingList[index].isLiked) {
              BlocProvider.of<FoodRatingBloc>(context).add(
                  FoodRatingUnDislikedFoodEvent(
                      foodRatingEntity: foodRatingList[index],
                      favoriteIndex: index));
            }
          },
        );
      },
    ));
  }

  Widget buildNoFoodDisliked() {
    return Padding(
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
    );
  }

  Widget buildNoFoodLiked() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Row(
        children: const [
          Expanded(
              child: Text(
            "You haven't liked any foods",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );
  }
}
