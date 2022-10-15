import 'package:camera/camera.dart';
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

  BottomNavigationBarItem getItem(
      String image, ThemeData theme, int index, String title) {
    if (index == 2) {
      return BottomNavigationBarItem(icon: buildScanIcon(image), label: title);
    }

    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        image,
        height: 32,
        width: 32,
        color: colorByIndex(theme, index),
      ),
      label: title,
    );
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
      getItem("assets/icons/home.svg", _theme, 0, "Home"),
      getItem("assets/icons/plan.svg", _theme, 1, "Plan"),
      getItem("assets/icons/scan.svg", _theme, 2, "Scan"),
      getItem("assets/icons/shopping_cart.svg", _theme, 3, "Market"),
      getItem("assets/icons/profile.svg", _theme, 4, "Profile"),
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
          onTap: (value) async {
            if (value == menuIndex) return;
            switch (value) {
              case 0:
                Navigator.pushReplacementNamed(context, PlanMealRoutes.home);
                break;
              case 1:
                Navigator.pushReplacementNamed(context, PlanMealRoutes.plan);
                break;
              case 2:
                await availableCameras().then((value) => Navigator.pushNamed(
                    context, PlanMealRoutes.scan,
                    arguments: value));
                break;
              case 3:
                Navigator.pushReplacementNamed(context, PlanMealRoutes.market);
                break;
              case 4:
                Navigator.pushReplacementNamed(context, PlanMealRoutes.profile);
                break;
            }
          },
          items: menuItems,
        ),
      ),
    );
  }
}
