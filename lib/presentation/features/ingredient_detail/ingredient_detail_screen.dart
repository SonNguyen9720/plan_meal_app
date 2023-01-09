import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/ingredient_detail/bloc/ingredient_detail_bloc.dart';

class IngredientDetailScreen extends StatelessWidget {
  final String ingredientId;
  final String name;
  final String imageUrl;

  const IngredientDetailScreen(
      {Key? key,
      required this.ingredientId,
      required this.name,
      required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<IngredientDetailBloc, IngredientDetailState>(
            builder: (context, state) {
      if (state is IngredientDetailLoading) {
        return const CircularProgressIndicator();
      }

      if (state is IngredientDetailSuccess) {
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxScroll) => [
              SliverAppBar(
                expandedHeight: 160,
                flexibleSpace: FlexibleSpaceBar(
                  background: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: AppColors.grey100,
                        ),
                ),
              ),
            ],
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    state.ingredientList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: state.ingredientList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Is incompatible with : ${state.ingredientList[index].name}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          "Description: ${state.ingredientList[index].note}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  );
                                }))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "This food is not incompatible with others",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
          ),
        );
      }

      if (state is IngredientDetailFailed) {
        return const Center(
          child: Text("Failed to load item"),
        );
      }
      return const Text("No state handle");
    }));
  }
}
