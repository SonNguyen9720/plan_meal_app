import 'package:flutter/material.dart';
import 'package:plan_meal_app/presentation/widgets/independent/bottom_menu.dart';

class PlanMealAppScaffold extends StatefulWidget {
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
  State<PlanMealAppScaffold> createState() => _PlanMealAppScaffoldState();
}

class _PlanMealAppScaffoldState extends State<PlanMealAppScaffold> {
  @override
  Widget build(BuildContext context) {
    List<Widget> tabBars = [];
    var _theme = Theme.of(context);
    if (widget.tabBarList != null) {
      for (var tabBarTitle in widget.tabBarList!) {
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
            controller: widget.tabController,
            indicatorColor: _theme.colorScheme.secondary,
            indicatorSize: TabBarIndicatorSize.tab,
          )
        : null;
    return Scaffold(
      backgroundColor: widget.background,
      appBar: widget.title != null
          ? AppBar(
              title: Text(widget.title!),
            )
          : null,
      body: widget.body,
      bottomNavigationBar: PlanMealAppBottomMenu(menuIndex: widget.bottomMenuIndex,),
    );
  }
}
