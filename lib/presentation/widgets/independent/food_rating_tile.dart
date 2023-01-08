import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';

class FoodRatingTile extends StatefulWidget {
  // final String imageUrl;
  final String name;
  final Function? onLike;
  final Function? onDislike;
  final bool isLiked;
  final bool isDisliked;

  const FoodRatingTile({
    Key? key,
    // required this.imageUrl,
    required this.name,
    this.onLike,
    this.onDislike,
    this.isLiked = false,
    this.isDisliked = false,
  }) : super(key: key);

  @override
  State<FoodRatingTile> createState() => _FoodRatingTileState();
}

class _FoodRatingTileState extends State<FoodRatingTile> {
  late bool isLiked;
  late bool isDisliked;

  @override
  void initState() {
    isLiked = widget.isLiked;
    isDisliked = widget.isDisliked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
          child: Row(
            children: [
              // Container(
              //   margin: const EdgeInsets.only(right: 16),
              //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              //   child: ClipRRect(
              //       borderRadius: BorderRadius.circular(8),
              //       child: Image.network(
              //         widget.imageUrl,
              //         width: 48,
              //         height: 48,
              //         fit: BoxFit.cover,
              //       )),
              // ),
              Expanded(
                  child: Text(
                widget.name,
                style: const TextStyle(fontSize: 20),
              )),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                    isDisliked = false;
                  });
                  widget.onLike!();
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      isLiked
                          ? const Icon(
                              Icons.thumb_up,
                              color: AppColors.green,
                              size: 24,
                            )
                          : const Icon(
                              Icons.thumb_up_outlined,
                              color: AppColors.green,
                              size: 24,
                            ),
                      const Text(
                        "Liked",
                        style: TextStyle(fontSize: 16, color: AppColors.green),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isDisliked = !isDisliked;
                    isLiked = false;
                  });
                  widget.onDislike;
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      isDisliked
                          ? const Icon(
                              Icons.thumb_down,
                              color: AppColors.red,
                              size: 24,
                            )
                          : const Icon(
                              Icons.thumb_down_outlined,
                              color: AppColors.red,
                              size: 24,
                            ),
                      const Text(
                        "Disliked",
                        style: TextStyle(fontSize: 16, color: AppColors.red),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
