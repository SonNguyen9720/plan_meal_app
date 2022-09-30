import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/presentation/features/market/groups/groups_bloc.dart';
import 'package:plan_meal_app/presentation/features/market/individual/individual_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/scaffold.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PlanMealAppScaffold(
      body: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) =>
                IndividualBloc()..add(IndividualLoadingDataEvent())),
        BlocProvider(create: (context) => GroupsBloc()),
      ], child: MarketScreenWrapper()),
      bottomMenuIndex: 3,
    ));
  }
}

class MarketScreenWrapper extends StatefulWidget {
  const MarketScreenWrapper({Key? key}) : super(key: key);

  @override
  State<MarketScreenWrapper> createState() => _MarketScreenWrapperState();
}

class _MarketScreenWrapperState extends State<MarketScreenWrapper>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Market",
          style: GoogleFonts.signika(fontSize: 24),
        ),
        Container(
          height: 48,
          width: 250,
          decoration: BoxDecoration(
              color: AppColors.backgroundTabBar,
              borderRadius: BorderRadius.circular(16)),
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: "Individual",
              ),
              Tab(
                text: "Groups",
              )
            ],
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.indicatorTab),
            labelColor: AppColors.backgroundTabBar,
            unselectedLabelColor: AppColors.indicatorTab,
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            controller: _tabController,
            children: [
              BlocBuilder<IndividualBloc, IndividualState>(
                  builder: (context, individualState) {
                if (individualState is IndividualLoadingItem) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (individualState is IndividualFailed) {
                  return const Center(
                    child: Text("Load data failed"),
                  );
                }

                if (individualState is IndividualNoItem) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            BlocProvider.of<IndividualBloc>(context).add(
                                IndividualChangeDateEvent(
                                    dateTime: newDate ?? DateTime.now()));
                          },
                          child: Text(individualState.dateTime),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            primary: AppColors.green,
                          )),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/no_item_add.svg"),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have item in list. ",
                                  style: GoogleFonts.signika(fontSize: 20),
                                ),
                                InkWell(
                                  child: Text(
                                    "Add item",
                                    style: GoogleFonts.signika(
                                        fontSize: 20, color: AppColors.green),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                return Text("No state to handle");
              }),
              Center(
                child: Text("Tabview 2"),
              )
            ],
          ),
        )),
      ],
    );
  }
}
