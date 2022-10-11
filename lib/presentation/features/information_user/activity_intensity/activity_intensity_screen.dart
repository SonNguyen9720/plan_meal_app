import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/data/model/user.dart';
import 'package:plan_meal_app/domain/entities/activity_intensity_entity.dart';
import 'package:plan_meal_app/presentation/features/information_user/activity_intensity/bloc/activity_intensity_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/linear_progess.dart';
import 'package:plan_meal_app/presentation/widgets/independent/navigate_button.dart';
import 'package:plan_meal_app/presentation/widgets/independent/radio_tile.dart';

class ActivityIntensityScreen extends StatefulWidget {
  const ActivityIntensityScreen({Key? key, required this.user})
      : super(key: key);

  final User user;

  @override
  State<ActivityIntensityScreen> createState() =>
      _ActivityIntensityScreenState();
}

class _ActivityIntensityScreenState extends State<ActivityIntensityScreen> {
  List<ActivityIntensityEntity> listTile = [
    const ActivityIntensityEntity(
        title: "Not Very Active", description: "Spend most of the day sitting"),
    const ActivityIntensityEntity(
        title: "Lightly Active",
        description: "Spend a good part of the day on your feet"),
    const ActivityIntensityEntity(
        title: "Active",
        description:
            "Spend a good part of the day doing some physical activity"),
    const ActivityIntensityEntity(
        title: "Very Active",
        description: "Spend most of the day doing heavy physical activity"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<ActivityIntensityBloc, ActivityIntensityState>(
            builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LinearProgress(value: 1 / 9),
                Text(
                  "What is your baseline activity level?",
                  style: GoogleFonts.signika(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
                ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => RadioTile(
                          iconsData: Icons.people,
                          title: listTile[index].title,
                          subTitle: listTile[index].description,
                          initialValue: state is ActivityIntensityInitial
                              ? state.render[index]
                              : false,
                          onChange: () {
                            if (state is ActivityIntensityInitial) {
                              _updateRadioList(!state.render[index], index);
                            }
                          },
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: NavigateButton(
                      text: "Next",
                      callbackFunc: () {
                        if (state is ActivityIntensityInitial) {
                          var activityIntensity =
                              state.activityIntensityMap.keys.firstWhere(
                                  (index) =>
                                      state.activityIntensityMap[index] == true,
                                  orElse: () => ActivityIntensity.empty);
                          _navigateFunction(widget.user, activityIntensity);
                        }
                      }),
                )
              ],
            ),
          );
        }, listener: (context, state) {
          if (state is ActivityIntensitySubmitted) {
            // print("Navigate to another screen");
            Navigator.of(context).pushNamed(PlanMealRoutes.signUp);
          }
        }));
  }

  void _updateRadioList(bool value, int index) {
    print("Call event");
    if (value) {
      BlocProvider.of<ActivityIntensityBloc>(context)
          .add(ActivityIntensityChoose(index));
    }
  }

  void _navigateFunction(User user, ActivityIntensity activityIntensity) {
    BlocProvider.of<ActivityIntensityBloc>(context)
        .add(ActivityIntensitySubmit(activityIntensity, user));
  }
}
