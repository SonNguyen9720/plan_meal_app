import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/widgets/independent/scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PlanMealAppScaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 64,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Welcome to user",
                          style: GoogleFonts.signika(fontSize: 24),
                        ),
                      )
                    ],
                  ),
                  Card(
                    elevation: 4,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Calories",
                              style: GoogleFonts.signika(fontSize: 20),
                            ),
                            Text(
                              "Remaining = Goal - Food + Exercise",
                              style: GoogleFonts.signika(color: Colors.grey),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: CircularPercentIndicator(
                                      radius: 52,
                                      center: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "2000",
                                            style: GoogleFonts.signika(
                                                fontSize: 32),
                                          ),
                                          Text(
                                            "Remaining",
                                            style: GoogleFonts.signika(
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      infoComponent(
                                          "Base goal",
                                          "2000",
                                          const Icon(
                                            Icons.flag,
                                            color: Colors.blue,
                                          )),
                                      infoComponent(
                                          "Food",
                                          "0",
                                          const Icon(
                                            Icons.flatware,
                                            color: Colors.green,
                                          )),
                                      infoComponent(
                                          "Exercise",
                                          "0",
                                          const Icon(
                                            Icons.hiking,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ]),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    child: Container(
                      height: 250,
                      padding: const EdgeInsets.all(16),
                      // width: MediaQuery.of(context).size.width - 16,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nutrition today",
                              style: GoogleFonts.signika(fontSize: 20)),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: PieChart(PieChartData(
                                    borderData: FlBorderData(show: false),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 30,
                                    sections: showingSections(),
                                  )),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    indicator(0xff0293ee, "Carb"),
                                    indicator(0xff845bef, "Fat"),
                                    indicator(0xfff8b250, "Protein"),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                  style: GoogleFonts.signika(
                      fontSize: 16, fontWeight: FontWeight.bold))
            ],
          ),
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      const fontSize = 16.0;
      const radius = 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
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
          style: GoogleFonts.signika(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
