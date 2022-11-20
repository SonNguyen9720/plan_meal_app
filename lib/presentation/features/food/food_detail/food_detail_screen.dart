import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScroll) => [
          SliverAppBar(
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                "https://cdn-prod.unimealplan.com/recipe/3c935bb0e26de3b8eeab3c91f4533302.jpeg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text("Oatmeal with Poached Egg", style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: const BoxDecoration(
                  color: AppColors.orangeLight,
                  borderRadius: BorderRadius.all(Radius.circular(24))
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.local_fire_department, color: AppColors.red,),
                    const SizedBox(width: 8,),
                    Text("690 kcal", style: TextStyle(color: AppColors.white, fontSize: 20,)),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: const BoxDecoration(
                  color: AppColors.breakfastTag,
                  borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text("27 g", style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),),
                      const Text("Proteins", style: TextStyle(
                        color: AppColors.gray,
                        fontSize: 16,
                      ),)
                    ],
                  ),
                  const SizedBox(width: 40,),
                  Column(
                    children: [
                      Text("27 g", style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),),
                      const Text("Carbs", style: TextStyle(
                        color: AppColors.gray,
                        fontSize: 16,
                      ),)
                    ],
                  ),
                  const SizedBox(width: 40,),
                  Column(
                    children: [
                      Text("27 g", style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),),
                      const Text("Fats", style: TextStyle(
                        color: AppColors.gray,
                        fontSize: 16,
                      ),)
                    ],
                  ),
                ],
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
