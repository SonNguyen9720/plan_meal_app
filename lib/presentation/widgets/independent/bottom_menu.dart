import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/presentation/features/home/bloc/home_bloc.dart';
import 'package:plan_meal_app/presentation/features/home/bmi_bloc/bmi_bloc.dart';
import 'package:plan_meal_app/presentation/features/home/home_screen.dart';
import 'package:plan_meal_app/presentation/features/market/market_screen.dart';
import 'package:plan_meal_app/presentation/features/plan_meal/plan_meal_screen.dart';
import 'package:plan_meal_app/presentation/features/profile/bloc/profile_bloc.dart';
import 'package:plan_meal_app/presentation/features/profile/profile_screen.dart';

class PlanMealAppBottomMenu extends StatelessWidget {
  const PlanMealAppBottomMenu({Key? key, required this.menuIndex})
      : super(key: key);

  final int menuIndex;

  Color colorByIndex(ThemeData theme, int index) {
    return index == menuIndex ? AppColors.green : const Color(0xFFABF7B1);
  }

  BottomNavigationBarItem getItem(String activeIcon, String inactiveIcon,
      ThemeData theme, int index, String title) {
    if (index == 2) {
      if (index == menuIndex) {
        return BottomNavigationBarItem(
            icon: buildScanIcon(activeIcon), label: title);
      }
      return BottomNavigationBarItem(
          icon: buildScanIcon(inactiveIcon), label: title);
    }

    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        index == menuIndex ? activeIcon : inactiveIcon,
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
          const BoxDecoration(shape: BoxShape.circle, color: AppColors.green),
      child: SvgPicture.asset(
        image,
        height: 24,
        width: 24,
        fit: BoxFit.none,
        color: AppColors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    List<BottomNavigationBarItem> menuItems = [
      getItem("assets/icons/home-filled.svg", "assets/icons/home-outlined.svg",
          _theme, 0, "Home"),
      getItem("assets/icons/note-filled.svg", "assets/icons/note-outlined.svg",
          _theme, 1, "Plan"),
      getItem("assets/icons/scan-filled.svg", "assets/icons/scan-outlined.svg",
          _theme, 2, "Scan"),
      getItem("assets/icons/shopping-cart-filled.svg",
          "assets/icons/shopping-cart-outlined.svg", _theme, 3, "Market"),
      getItem("assets/icons/profile-filled.svg",
          "assets/icons/profile-outlined.svg", _theme, 4, "Profile"),
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
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedItemColor: AppColors.green,
          elevation: 0.0,
          onTap: (value) async {
            if (value == menuIndex) return;
            switch (value) {
              case 0:
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) => HomeBloc(
                                      userRepository:
                                          RepositoryProvider.of<UserRepository>(
                                              context))
                                    ..add(HomeGetUserOverviewEvent(
                                        dateTime: DateTime.now())),
                                ),
                                BlocProvider(
                                  create: (context) => BmiBloc(
                                      userRepository:
                                          RepositoryProvider.of<UserRepository>(
                                              context))
                                    ..add(BmiLoadEvent()),
                                ),
                              ],
                              child: const HomeScreen(),
                            )));
                break;
              case 1:
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const PlanMealScreen()));
                break;
              case 2:
                await Navigator.pushNamed(context, PlanMealRoutes.scan,
                    arguments: value);
                break;
              case 3:
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const MarketScreen()));
                break;
              case 4:
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => BlocProvider(
                              create: (context) => ProfileBloc(
                                  groupRepository:
                                      RepositoryProvider.of<GroupRepository>(
                                          context))
                                ..add(ProfileLoadGroupEvent()),
                              child: const ProfileScreen(),
                            )));
                break;
            }
          },
          items: menuItems,
        ),
      ),
    );
  }
}
