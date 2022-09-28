import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plan_meal_app/config/routes.dart';

class PlanMealAppBottomMenu extends StatelessWidget {
  const PlanMealAppBottomMenu({Key? key, required this.menuIndex})
      : super(key: key);

  final int menuIndex;

  Color colorByIndex(ThemeData theme, int index) {
    return index == menuIndex
        ? theme.colorScheme.secondary
        : theme.primaryColorLight;
  }

  BottomNavigationBarItem getItem(String image, ThemeData theme, int index) {
    if (index == 2) {
      return BottomNavigationBarItem(icon: buildScanIcon(image));
    }

    return BottomNavigationBarItem(
        icon: SvgPicture.asset(
      image,
      height: 32,
      width: 32,
      color: colorByIndex(theme, index),
    ));
  }

  Widget buildScanIcon(String image) {
    return Container(
      height: 48,
      width: 48,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
      child: SvgPicture.asset(
        image,
        height: 24,
        width: 24,
        fit: BoxFit.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    List<BottomNavigationBarItem> menuItems = [
      getItem("assets/icons/home.svg", _theme, 0),
      getItem("assets/icons/plan.svg", _theme, 1),
      getItem("assets/icons/scan.svg", _theme, 2),
      getItem("assets/icons/shopping_cart.svg", _theme, 3),
      getItem("assets/icons/profile.svg", _theme, 4),
    ];
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)
          ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: menuIndex,
          onTap: (value) {
            switch (value) {
              case 0:
                Navigator.pushNamed(context, PlanMealRoutes.home);
                break;
              case 1:
                Navigator.pushNamed(context, PlanMealRoutes.plan);
                break;
              case 2:
                Navigator.pushNamed(context, PlanMealRoutes.scan);
                break;
              case 3:
                Navigator.pushNamed(context, PlanMealRoutes.market);
                break;
              case 4:
                Navigator.pushNamed(context, PlanMealRoutes.profile);
                break;
            }
          },
          items: menuItems,
        ),
      ),
    );
  }
}
