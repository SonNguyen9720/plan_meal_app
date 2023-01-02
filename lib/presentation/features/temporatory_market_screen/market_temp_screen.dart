import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/widgets/independent/scaffold.dart';

class MarketTempScreen extends StatelessWidget {
  const MarketTempScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: PlanMealAppScaffold(
      body: MarketTempScreenWrapper(),
      bottomMenuIndex: 3,
    ));
  }
}

class MarketTempScreenWrapper extends StatefulWidget {
  const MarketTempScreenWrapper({Key? key}) : super(key: key);

  @override
  State<MarketTempScreenWrapper> createState() =>
      _MarketTempScreenWrapperState();
}

class _MarketTempScreenWrapperState extends State<MarketTempScreenWrapper>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: const Text(
            "Market",
            style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 48,
          width: 250,
          decoration: BoxDecoration(
              color: AppColors.backgroundTabBar,
              borderRadius: BorderRadius.circular(6)),
          child: TabBar(
            controller: tabController,
            tabs: const [
              Tab(
                text: "Individual",
              ),
              Tab(
                text: "Groups",
              )
            ],
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.indicatorTab),
            labelColor: AppColors.backgroundTabBar,
            unselectedLabelColor: AppColors.indicatorTab,
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: TabBarView(
            controller: tabController,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Shopping list",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: const Text(
                              "Add +",
                              style: TextStyle(
                                  fontSize: 16, color: AppColors.gray),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.gray),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Container(
                                //     margin: const EdgeInsets.only(right: 16),
                                //     height: 96,
                                //     width: 96,
                                //     decoration: BoxDecoration(
                                //       color: AppColors.green,
                                //       borderRadius: BorderRadius.circular(16)
                                //     ),
                                //     child: Column(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: const [
                                //         Text(
                                //           "25 / 12",
                                //           style: TextStyle(
                                //               color: AppColors.white,
                                //               fontWeight: FontWeight.bold, fontSize: 20),
                                //         ),
                                //         Text(
                                //           "-",
                                //           style: TextStyle(
                                //               color: AppColors.white,
                                //               fontWeight: FontWeight.bold, fontSize: 20),
                                //         ),
                                //         Text(
                                //           "27 / 12",
                                //           style: TextStyle(
                                //               color: AppColors.white,
                                //               fontWeight: FontWeight.bold, fontSize: 20),
                                //         ),
                                //       ],
                                //     )),
                                Container(
                                  margin: const EdgeInsets.only(right: 16),
                                  child: Image.asset(
                                    "assets/shopping_cart_logo.png",
                                    height: 64,
                                    width: 64,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Shopping list 1",
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        "Date: 25/12 - 27/12",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.gray),
                                      ),
                                      Text(
                                        "Note: BHX - Thu Duc",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.gray),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/food/check_circle.svg",
                                      height: 24,
                                      width: 24,
                                      color: AppColors.green,
                                    ),
                                    const Text("Complete", style: TextStyle(color: AppColors.green, fontSize: 14),)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
                ],
              ),
              Container(),
            ],
          ),
        ))
      ],
    );
  }
}
