import 'package:flutter/material.dart';
import 'package:plan_meal_app/presentation/widgets/independent/bottom_menu.dart';

class PlanMealAppScaffold extends StatelessWidget {
  const PlanMealAppScaffold(
      {Key? key,
      this.background,
      this.title,
      required this.body,
      required this.bottomMenuIndex,
      this.tabBarList,
      this.tabController})
      : super(key: key);

  final Color? background;
  final String? title;
  final Widget body;
  final int bottomMenuIndex;
  final List<String>? tabBarList;
  final TabController? tabController;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabBars = [];
    var _theme = Theme.of(context);
    if (tabBarList != null) {
      for (var tabBarTitle in tabBarList!) {
        tabBars.add(Tab(
          key: UniqueKey(),
          text: tabBarTitle,
        ));
      }
    }

    Widget? tabWidget = tabBars.isNotEmpty
        ? TabBar(
            unselectedLabelColor: _theme.primaryColor,
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.normal),
            labelColor: _theme.primaryColor,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: tabBars,
            controller: tabController,
            indicatorColor: _theme.colorScheme.secondary,
            indicatorSize: TabBarIndicatorSize.tab,
          )
        : null;
    return Scaffold(
      backgroundColor: background,
      appBar: title != null
          ? AppBar(
              title: Text(title!),
            )
          : null,
      body: body,
      bottomNavigationBar: bottomMenuIndex != 2
          ? PlanMealAppBottomMenu(menuIndex: bottomMenuIndex)
          : null,
    );
  }
}
