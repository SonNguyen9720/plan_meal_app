import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/scan_food/bloc/scan_food_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/add_food_button.dart';
import 'package:plan_meal_app/presentation/widgets/independent/scaffold.dart';

class ScanFoodScreen extends StatefulWidget {
  const ScanFoodScreen({Key? key}) : super(key: key);

  @override
  State<ScanFoodScreen> createState() => _ScanFoodScreenState();
}

class _ScanFoodScreenState extends State<ScanFoodScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlanMealAppScaffold(
      body: BlocBuilder<ScanFoodBloc, ScanFoodState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTitle(context, state),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: buildImage(context, state),
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  height: 40,
                ),
                buildButton(context, state),
              ],
            ),
          );
        },
      ),
      bottomMenuIndex: 2,
    );
  }

  Widget buildImage(BuildContext context, ScanFoodState state) {
    var size = MediaQuery.of(context).size;
    if (state is ScanFoodLoadImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          state.imageUrl,
          height: size.width * 0.8,
          width: size.width * 0.8,
          fit: BoxFit.cover,
        ),
      );
    }
    return SizedBox(
      height: size.width * 0.8,
      width: size.width * 0.8,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(16),
        dashPattern: const [5, 5],
        color: AppColors.green,
        strokeWidth: 1.5,
        child: const Center(
          child: Text(
            "No image available",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget buildTitle(BuildContext context, ScanFoodState state) {
    return const Text(
      "Scan food",
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildButton(BuildContext context, ScanFoodState state) {
    if (state is ScanFoodInitial) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 60,
              width: 90,
              decoration: const BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: IconButton(
                  onPressed: () {
                    BlocProvider.of<ScanFoodBloc>(context)
                        .add(ScanFoodChooseImageFromCameraEvent());
                  },
                  icon: const Icon(
                    Icons.camera,
                    size: 45,
                    color: AppColors.white,
                  ))),
          const SizedBox(
            width: 20,
          ),
          Container(
              height: 60,
              width: 90,
              decoration: const BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: IconButton(
                  onPressed: () {
                    BlocProvider.of<ScanFoodBloc>(context)
                        .add(ScanFoodChooseImageFromGalleryEvent());
                  },
                  icon: const Icon(
                    Icons.image,
                    size: 45,
                    color: AppColors.white,
                  )))
        ],
      );
    } else if (state is ScanFoodLoadImage) {
      return Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.foodDetectEntity.length,
                itemBuilder: (BuildContext context, int index) {
                  if (state.foodDetectEntity[index].name.isEmpty &&
                      state.foodDetectEntity[index].calories == 0 &&
                      state.foodDetectEntity[index].imageUrl.isEmpty) {
                    return AddFoodButton(onPressed: () {

                    });
                  }
                  return Card(
                    child: Container(
                      height: 80,
                      width: 300,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: state
                                    .foodDetectEntity[index].imageUrl.isNotEmpty
                                ? Image.network(
                                    state.imageUrl,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  )
                                : const SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: FlutterLogo(),
                                  ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  state.foodDetectEntity[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                              Text(
                                state.foodDetectEntity[index].calories
                                        .toString() +
                                    " kcals",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.gray,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    } else if (state is ScanFoodNoImage) {
      return const Center(
        child: Text("Sorry we can't detect food of you"),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(
          color: AppColors.green,
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
