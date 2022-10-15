import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/presentation/features/scan_food/bloc/scan_food_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/scaffold.dart';

class ScanFoodScreen extends StatefulWidget {
  const ScanFoodScreen({Key? key, this.cameras}) : super(key: key);
  final List<CameraDescription>? cameras;

  @override
  State<ScanFoodScreen> createState() => _ScanFoodScreenState();
}

class _ScanFoodScreenState extends State<ScanFoodScreen> {
  late CameraController cameraController;

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![0]);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return PlanMealAppScaffold(
      body: BlocBuilder<ScanFoodBloc, ScanFoodState>(
        builder: (context, state) {
          if (state is ScanFoodLoadingCamera) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ScanFoodLoadedCamera) {
            return Stack(children: [
              CameraPreview(cameraController),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                      color: Colors.black),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () {},
                          iconSize: 50,
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.circle, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomMenuIndex: 2,
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> initCamera(CameraDescription cameraDescription) async {
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.max);
    try {
      await cameraController.initialize().then((value) {
        if (!mounted) {
          BlocProvider.of<ScanFoodBloc>(context)
              .add(const InitCameraEvent(false));
        } else {
          BlocProvider.of<ScanFoodBloc>(context)
              .add(const InitCameraEvent(true));
        }
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }
}
