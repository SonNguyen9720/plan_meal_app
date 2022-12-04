import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';
import 'package:plan_meal_app/domain/string_utils.dart';
import 'package:plan_meal_app/presentation/features/home/bloc/home_bloc.dart';
import 'package:plan_meal_app/presentation/features/home/bmi_bloc/bmi_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PlanMealAppScaffold(
          body: BlocBuilder<HomeBloc, HomeState>(
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
                                "Welcome, \n${PreferenceUtils.getString(
                                    "name")}",
                                style: const TextStyle(fontSize: 24),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
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
                                                  "${state.userOverviewEntity
                                                      ?.baseCalories
                                                      ?.toStringAsFixed(0) ??
                                                      0}",
                                                  const Icon(
                                                    Icons.flag,
                                                    color: Colors.blue,
                                                  )),
                                              infoComponent(
                                                  "Food",
                                                  "${state.userOverviewEntity
                                                      ?.totalCalories
                                                      ?.toStringAsFixed(0) ??
                                                      0}",
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
                          margin: const EdgeInsets.symmetric(vertical: 4),
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
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: Card(
                            elevation: 4,
                            child: Container(
                              height: 330,
                              padding: const EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Weight Tracking",
                                    style: TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 250,
                                    child: LineChart(
                                      LineChartData(
                                        lineBarsData: [
                                          LineChartBarData(
                                              spots: [
                                                FlSpot(0, 65),
                                                FlSpot(1, 66),
                                                FlSpot(2, 67),
                                                FlSpot(3, 65.5),
                                              ],
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
                                                color: Colors.transparent),
                                            right: BorderSide(
                                                color: Colors.transparent),
                                            top: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                        ),
                                        titlesData: FlTitlesData(
                                            show: true,
                                            leftTitles:
                                            SideTitles(showTitles: false),
                                            topTitles:
                                            SideTitles(showTitles: false),
                                            bottomTitles: SideTitles(
                                              showTitles: true,
                                              getTitles: bottomTitleWidgets,
                                              interval: 1,
                                              margin: 16,
                                              textAlign: TextAlign.center,
                                            )),
                                        minX: 0,
                                        maxX: 3,
                                        maxY: 80,
                                        minY: 40,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
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
                                          style: TextStyle(fontSize: 20,
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
                                        RichText(text: TextSpan(
                                            text: "Your weight is: ",
                                            style: const TextStyle(
                                                fontSize: 18, color: AppColors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: StringUtils.parseString(
                                                    state.type),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: getColorBMI(
                                                        double.parse(
                                                            state.bmi)),
                                                    fontWeight: FontWeight
                                                        .bold),
                                              ),
                                            ]
                                        )),
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

  List<PieChartSectionData> showingSections(BuildContext context,
      HomeInitial state) {
    if (state.userOverviewEntity!.totalCalories == 0) {
      return [
        PieChartSectionData(
          color: const Color(0XFFC0C0C0),
          value: 100,
          title: '0%',
          radius: 80,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
        )
      ];
    }
    double carbPercent = state.userOverviewEntity!.carb! /
        state.userOverviewEntity!.totalCalories! *
        100;
    double fatPercent = state.userOverviewEntity!.fat! /
        state.userOverviewEntity!.totalCalories! *
        100;
    double proteinPercent = 100 - carbPercent - fatPercent;
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      var fontSize = isTouched ? 25.0 : 16.0;
      var radius = isTouched ? 90.0 : 80.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0XFF77D392),
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
            color: const Color(0XFFE75C51),
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
            color: const Color(0XFFF09F44),
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

  Widget indicator(int color, String title) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: Color(color)),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  String bottomTitleWidgets(double value) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = "week 1";
        break;
      case 1:
        text = "week 2";
        break;
      case 2:
        text = "week 3";
        break;
      case 3:
        text = "week 4";
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
                            pieTouchResponse.touchedSection!
                                .touchedSectionIndex;
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
              children: [
                indicator(0XFF77D392, "Carb"),
                indicator(0xFFE75C51, "Fat"),
                indicator(0xFFF09F44, "Protein"),
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
    var totalCalories = state.userOverviewEntity!.totalCalories!;
    if (baseCalories >= totalCalories) {
      var remainCalories = baseCalories - totalCalories;
      var ratio = totalCalories / baseCalories;
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
              Text(
                "Remaining",
                style: GoogleFonts.signika(fontSize: 14),
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
      var modCalories = totalCalories % baseCalories;
      var remainCalories = totalCalories - baseCalories;
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
    return GestureDetector(
      onTap: () {},
      child: CircleAvatar(
        backgroundColor: AppColors.green,
        radius: 48,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(64),
              child: Image.network(imageUrl)),
        ),
      ),
    );
  }
}
