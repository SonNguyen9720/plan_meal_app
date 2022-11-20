import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/scan_food/bloc/scan_food_bloc.dart';
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
    var size = MediaQuery.of(context).size;
    return PlanMealAppScaffold(
      body: BlocBuilder<ScanFoodBloc, ScanFoodState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Food Scanner", style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: buildImage(context, state),
                ),
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 60,
                        width: 90,
                        decoration: const BoxDecoration(
                            color: AppColors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.camera,
                              size: 45,
                              color: AppColors.white,
                            ))),
                    const SizedBox(width: 40,),
                    Container(
                        height: 60,
                        width: 90,
                        decoration: const BoxDecoration(
                            color: AppColors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.image,
                              size: 45,
                              color: AppColors.white,
                            )))
                  ],
                )
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
      return const Text("has image");
    }
    return SizedBox(
      height: size.width * 0.9,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(15),
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

  @override
  void dispose() {
    super.dispose();
  }

// Future<void> initCamera(CameraDescription cameraDescription) async {
//   cameraController =
//       CameraController(cameraDescription, ResolutionPreset.max);
//   try {
//     await cameraController.initialize().then((value) {
//       if (!mounted) {
//         BlocProvider.of<ScanFoodBloc>(context)
//             .add(const InitCameraEvent(false));
//       } else {
//         BlocProvider.of<ScanFoodBloc>(context)
//             .add(const InitCameraEvent(true));
//       }
//     });
//   } on CameraException catch (e) {
//     debugPrint("camera error $e");
//   }
// }
}
