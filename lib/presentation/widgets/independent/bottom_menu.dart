import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      return BottomNavigationBarItem(icon: buildScanIcon());
    }

    return BottomNavigationBarItem(
        icon: SvgPicture.asset(
      image,
      height: 32,
      width: 32,
      color: colorByIndex(theme, index),
    ));
  }

  Widget buildScanIcon() {
    return Container(
      height: 48,
      width: 48,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
      child: SvgPicture.asset(
        "assets/icon/Scan.svg",
        height: 24,
        width: 24,
        fit: BoxFit.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Container();
  }
}
