import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:plan_meal_app/config/notification_service.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/weight_entity.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';
import 'package:plan_meal_app/domain/string_utils.dart';
import 'package:plan_meal_app/domain/user_utils.dart';
import 'package:plan_meal_app/presentation/features/home/bloc/home_bloc.dart';
import 'package:plan_meal_app/presentation/features/home/bmi_bloc/bmi_bloc.dart';
import 'package:plan_meal_app/presentation/features/home/weight_cubit/weight_cubit.dart';
import 'package:plan_meal_app/presentation/widgets/independent/chart_indicator.dart';
import 'package:plan_meal_app/presentation/widgets/independent/scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int touchedIndex = -1;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("--------------- on Message ---------------");
        print(
            "on Message: ${message.notification?.title} / ${message.notification?.body}");
      }
      NotificationService notificationService = NotificationService();
      notificationService.displayNotification(
          message.notification?.title ?? "No title",
          message.notification?.body ?? "Body");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PlanMealAppScaffold(
          body: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is HomeError) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text(state.message),
                          actions: [
                            TextButton(
                              onPressed: () {
                                UserUtils.logOut(context);
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ));
              }
            },
            builder: (context, state) {
              if (state is HomeInitial) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            buildUserAvatar(),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Welcome, \n${PreferenceUtils.getString("name")}",
                                style: const TextStyle(fontSize: 24),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: Card(
                            elevation: 4,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Calories",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "Remaining = Goal - Food + Exercise",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          buildCircularIndicator(
                                              context, state),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              infoComponent(
                                                  "Base goal",
                                                  "${state.userOverviewEntity?.baseCalories?.toStringAsFixed(0) ?? 0}",
                                                  const Icon(
                                                    Icons.flag,
                                                    color: Colors.blue,
                                                  )),
                                              infoComponent(
                                                  "Food",
                                                  "${state.userOverviewEntity?.currentCalories?.toStringAsFixed(0) ?? 0}",
                                                  const Icon(
                                                    Icons.flatware,
                                                    color: Colors.green,
                                                  )),
                                              // infoComponent(
                                              //     "Exercise",
                                              //     "0",
                                              //     const Icon(
                                              //       Icons.hiking,
                                              //       color: Colors.red,
                                              //     )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: Card(
                            elevation: 4,
                            child: Container(
                              height: 250,
                              padding: const EdgeInsets.all(16),
                              // width: MediaQuery.of(context).size.width - 16,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Nutrition today",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  buildPieChart(context, state),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: Card(
                            elevation: 4,
                            child: BlocBuilder<WeightCubit, WeightState>(
                              builder: (context, state) {
                                if (state is WeightInitial) {
                                  return Container(
                                    height: 330,
                                    padding: const EdgeInsets.all(25),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "Weight Tracking",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 250,
                                          child: LineChart(
                                            LineChartData(
                                              lineBarsData: [
                                                LineChartBarData(
                                                    spots: parseToNode(
                                                        state.weightList),
                                                    isCurved: false,
                                                    colors: [Colors.orange]),
                                              ],
                                              gridData: FlGridData(
                                                drawVerticalLine: false,
                                                drawHorizontalLine: true,
                                              ),
                                              borderData: FlBorderData(
                                                show: true,
                                                border: const Border(
                                                  bottom: BorderSide(
                                                      color: Color(0xff4e4965),
                                                      width: 4),
                                                  left: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                  right: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                  top: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                ),
                                              ),
                                              titlesData: FlTitlesData(
                                                show: true,
                                                leftTitles: SideTitles(
                                                    showTitles: false),
                                                rightTitles: SideTitles(
                                                    showTitles: true,
                                                    interval: (state.max -
                                                            state.min + 0
                                                            ) ~/
                                                        4 /
                                                        1.0),
                                                topTitles: SideTitles(
                                                    showTitles: false),
                                                bottomTitles: SideTitles(
                                                  showTitles: true,
                                                  getTitles: bottomTitleWidgets,
                                                  interval: 1,
                                                  margin: 16,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              minX: 0,
                                              maxX: 3,
                                              maxY: state.max.toDouble(),
                                              minY: state.min.toDouble(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: Card(
                            elevation: 4,
                            child: BlocBuilder<BmiBloc, BmiState>(
                              builder: (context, state) {
                                if (state is BmiInitial) {
                                  return Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Current BMI",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          state.bmi,
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        RichText(
                                            text: TextSpan(
                                                text: "Your weight is: ",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: AppColors.black),
                                                children: <TextSpan>[
                                              TextSpan(
                                                text: StringUtils.parseString(
                                                    state.type),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: getColorBMI(
                                                        double.parse(
                                                            state.bmi)),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ])),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 10,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.horizontal(
                                                          left: Radius.circular(
                                                              15)),
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 10,
                                                color: Colors.green,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 10,
                                                color: Colors.yellow.shade700,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 10,
                                                color: Colors.orange,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 10,
                                                color: Colors.deepOrangeAccent,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 10,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.horizontal(
                                                          right:
                                                              Radius.circular(
                                                                  15)),
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text('00',
                                                style: TextStyle(
                                                  color: Colors.transparent,
                                                )),
                                            Text('18.5'),
                                            Text('25.0'),
                                            Text('30.0'),
                                            Text('35.0'),
                                            Text('40.0'),
                                            Text('00',
                                                style: TextStyle(
                                                  color: Colors.transparent,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          bottomMenuIndex: 0),
    );
  }

  Widget infoComponent(String title, String value, Icon icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text(value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold))
            ],
          ),
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections(
      BuildContext context, HomeInitial state) {
    int totalNutrition = state.userOverviewEntity!.carb! +
        state.userOverviewEntity!.protein! +
        state.userOverviewEntity!.fat!;
    if (state.userOverviewEntity!.totalCalories == 0) {
      return [
        PieChartSectionData(
          color: const Color(0xFFC0C0C0),
          value: 100,
          title: '0%',
          radius: 80,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        )
      ];
    }
    double carbPercent = state.userOverviewEntity!.carb! / totalNutrition * 100;
    double fatPercent = state.userOverviewEntity!.fat! / totalNutrition * 100;
    double proteinPercent = 100 - carbPercent - fatPercent;
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      var fontSize = isTouched ? 25.0 : 16.0;
      var radius = isTouched ? 90.0 : 80.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFF77D392),
            value: carbPercent,
            title: '${carbPercent.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xFFE75C51),
            value: fatPercent,
            title: '${fatPercent.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFFF09F44),
            value: proteinPercent,
            title: '${proteinPercent.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }

  String bottomTitleWidgets(double value) {
    String text;
    switch (value.toInt()) {
      case 0:
        var newDateTime = DateTime.now().subtract(const Duration(days: 21));
        text = "${newDateTime.day}/${newDateTime.month}";
        break;
      case 1:
        var newDateTime = DateTime.now().subtract(const Duration(days: 14));
        text = "${newDateTime.day}/${newDateTime.month}";
        break;
      case 2:
        var newDateTime = DateTime.now().subtract(const Duration(days: 7));
        text = "${newDateTime.day}/${newDateTime.month}";
        break;
      case 3:
        text = "${DateTime.now().day}/${DateTime.now().month}";
        break;
      default:
        return "";
    }

    return text;
  }

  Color getColorBMI(double bmi) {
    if (bmi < 18.5) {
      return Colors.blue;
    } else if (bmi >= 18.5 && bmi < 25.0) {
      return Colors.green;
    } else if (bmi >= 25.0 && bmi < 30) {
      return Colors.yellow.shade700;
    } else if (bmi >= 30 && bmi < 35) {
      return Colors.orange;
    } else if (bmi >= 35 && bmi < 40) {
      return Colors.deepOrangeAccent;
    } else if (bmi >= 40) {
      return Colors.red;
    }
    return Colors.white;
  }

  Widget buildPieChart(BuildContext context, HomeInitial state) {
    if (state.userOverviewEntity != null) {
      return Expanded(
        child: Row(
          children: [
            Expanded(
              child: PieChart(PieChartData(
                pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                }),
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: showingSections(context, state),
              )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ChartIndicator(color: AppColors.green, title: "Carb"),
                ChartIndicator(color: AppColors.red, title: "Fat"),
                ChartIndicator(color: AppColors.orangeYellow, title: 'Protein'),
              ],
            )
          ],
        ),
      );
    }
    return Container();
  }

  Widget buildCircularIndicator(BuildContext context, HomeInitial state) {
    if (state.userOverviewEntity == null) {
      return Container();
    }
    var baseCalories = state.userOverviewEntity!.baseCalories!;
    var currentCalories = state.userOverviewEntity!.currentCalories!;
    if (baseCalories >= currentCalories) {
      var remainCalories = baseCalories - currentCalories;
      var ratio = currentCalories / baseCalories;
      return Expanded(
        child: CircularPercentIndicator(
          percent: ratio,
          radius: 64,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                remainCalories.toStringAsFixed(0),
                style: const TextStyle(fontSize: 32),
              ),
              const Text(
                "Remaining",
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
          circularStrokeCap: CircularStrokeCap.round,
          lineWidth: 10,
          animation: true,
          animationDuration: 2500,
          progressColor: AppColors.green,
        ),
      );
    } else {
      var modCalories = currentCalories % baseCalories;
      var remainCalories = currentCalories - baseCalories;
      var ratio = modCalories / baseCalories;
      return Expanded(
        child: CircularPercentIndicator(
          percent: ratio,
          radius: 64,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                remainCalories.toStringAsFixed(0),
                style: const TextStyle(fontSize: 32, color: AppColors.red),
              ),
              const Text(
                "Over",
                style: TextStyle(fontSize: 14, color: AppColors.red),
              )
            ],
          ),
          circularStrokeCap: CircularStrokeCap.round,
          lineWidth: 10,
          animation: false,
          progressColor: AppColors.red,
          backgroundColor: const Color(0xFFFA8072),
        ),
      );
    }
  }

  Widget buildUserAvatar() {
    var imageUrl = PreferenceUtils.getString("imageUrl") ?? "";
    if (imageUrl.isEmpty) {
      return GestureDetector(
        onTap: () {},
        child: const Icon(
          Icons.person,
          color: Colors.grey,
          size: 64,
        ),
      );
    }
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: AppColors.green,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.green, width: 4.0),
      ),
    );
  }

  List<FlSpot> parseToNode(List<WeightEntity> weightList) {
    List<FlSpot> result = [];
    if (weightList.isEmpty) {
      return [];
    }
    DateTime weekendDay4 = DateTimeUtils.getWeekendDate(DateTime.now());
    DateTime weekendDay3 = weekendDay4.subtract(const Duration(days: 7));
    DateTime weekendDay2 = weekendDay3.subtract(const Duration(days: 7));
    DateTime weekendDay1 = weekendDay2.subtract(const Duration(days: 7));
    for (var weightEntity in weightList) {
      if (weightEntity.date.isBefore(weekendDay1)) {
        result.add(FlSpot(0, weightEntity.weight / 1.0));
      } else if (weightEntity.date.isAfter(weekendDay1) &&
          weightEntity.date.isBefore(weekendDay2)) {
        result.add(FlSpot(1, weightEntity.weight / 1.0));
      } else if (weightEntity.date.isAfter(weekendDay2) &&
          weightEntity.date.isBefore(weekendDay3)) {
        result.add(FlSpot(2, weightEntity.weight / 1.0));
      } else if (weightEntity.date.isAfter(weekendDay3) &&
          weightEntity.date.isBefore(weekendDay4)) {
        result.add(FlSpot(3, weightEntity.weight / 1.0));
      }
    }
    return result;
  }
}
