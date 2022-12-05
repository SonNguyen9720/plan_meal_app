import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/menu_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/string_utils.dart';
import 'package:plan_meal_app/presentation/features/plan_meal/bloc/plan_meal_bloc.dart';
import 'package:plan_meal_app/presentation/features/plan_meal/group_bloc/plan_meal_group_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/food_type_tag.dart';
import 'package:plan_meal_app/presentation/widgets/independent/meal_tag.dart';
import 'package:plan_meal_app/presentation/widgets/independent/scaffold.dart';

class PlanMealScreen extends StatelessWidget {
  const PlanMealScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PlanMealAppScaffold(
      bottomMenuIndex: 1,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PlanMealBloc(
                groupRepository:
                    RepositoryProvider.of<GroupRepository>(context),
                menuRepository: RepositoryProvider.of<MenuRepository>(context))
              ..add(PlanMealLoadData(dateTime: DateTime.now())),
          ),
          BlocProvider(
              create: (context) => PlanMealGroupBloc(
                  menuRepository:
                      RepositoryProvider.of<MenuRepository>(context))
                ..add(PlanMealGroupLoadData(dateTime: DateTime.now()))),
        ],
        child: const PlanMealScreenWrapper(),
      ),
    ));
  }
}

class PlanMealScreenWrapper extends StatefulWidget {
  const PlanMealScreenWrapper({Key? key}) : super(key: key);

  @override
  State<PlanMealScreenWrapper> createState() => _PlanMealScreenWrapperState();
}

class _PlanMealScreenWrapperState extends State<PlanMealScreenWrapper>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: const Text(
            "Daily Plan",
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
                borderRadius: BorderRadius.circular(6),
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
              BlocConsumer<PlanMealBloc, PlanMealState>(
                listener: (context, state) async {
                  if (state is PlanMealWaiting) {
                    EasyLoading.show(
                      status: "Loading ...",
                      maskType: EasyLoadingMaskType.black,
                    );
                  } else if (state is PlanMealFinished) {
                    if (EasyLoading.isShow) {
                      await EasyLoading.dismiss();
                    }
                  }
                },
                buildWhen: (previousState, state) {
                  if (state is PlanMealWaiting || state is PlanMealFinished) {
                    return false;
                  }
                  return true;
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        buildDateButton(context, state),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(child: buildPlanMealBody(context, state)),
                        // buildSubmitPlanMealButton(context, state),
                      ],
                    ),
                  );
                },
              ),
              BlocBuilder<PlanMealGroupBloc, PlanMealGroupState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        buildDateButtonForGroup(context, state),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                            child: buildPlanMealBodyForGroup(context, state)),
                        // buildSubmitPlanMealButton(context, state),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ))
      ],
    );
  }

  Widget buildPlanMealBody(BuildContext context, PlanMealState state) {
    if (state is PlanMealLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is PlanMealNoMeal) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/no_item_add.svg"),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have item in list. ",
                style: TextStyle(fontSize: 20),
              ),
              InkWell(
                child: const Text(
                  "Add item",
                  style: TextStyle(fontSize: 20, color: AppColors.green),
                ),
                onTap: () {
                  Map<String, dynamic> args = {
                    'date': state.dateTime,
                    'type': 'individual'
                  };
                  Navigator.of(context)
                      .pushNamed(PlanMealRoutes.addFood, arguments: args)
                      .whenComplete(() => BlocProvider.of<PlanMealBloc>(context)
                          .add(PlanMealLoadData(dateTime: state.dateTime)));
                },
              ),
            ],
          ),
        ],
      );
    } else if (state is PlanMealHasMeal) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Food list",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Map<String, dynamic> args = {
                      'date': state.dateTime,
                      'type': 'individual'
                    };
                    Navigator.of(context)
                        .pushNamed(PlanMealRoutes.addFood, arguments: args)
                        .whenComplete(() =>
                            BlocProvider.of<PlanMealBloc>(context).add(
                                PlanMealLoadData(dateTime: state.dateTime)));
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: const Text(
                      "Add +",
                      style: TextStyle(fontSize: 16, color: AppColors.gray),
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
            child: ListView.builder(
                itemCount: state.foodMealEntity.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: ValueKey(index),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.4,
                      children: [
                        SlidableAction(
                          autoClose: false,
                          onPressed: (context) {
                            Navigator.of(context)
                                .pushNamed(PlanMealRoutes.updateFood,
                                    arguments: state.foodMealEntity[index])
                                .whenComplete(() =>
                                    BlocProvider.of<PlanMealBloc>(context).add(
                                        PlanMealLoadData(
                                            dateTime: state.dateTime)));
                          },
                          backgroundColor: AppColors.blue,
                          foregroundColor: AppColors.white,
                          icon: Icons.edit,
                          label: 'Update',
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            BlocProvider.of<PlanMealBloc>(context).add(
                                PlanMealRemoveDishEvent(
                                    dishId: state
                                        .foodMealEntity[index].foodToMenuId
                                        .toString(),
                                    dateTime: state.dateTime,
                                    meal: state.foodMealEntity[index].meal,
                                    foodMealEntity: state.foodMealEntity,
                                    member: state.member));
                          },
                          backgroundColor: AppColors.red,
                          foregroundColor: AppColors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(PlanMealRoutes.foodDetail,
                                arguments: state.foodMealEntity[index].foodId
                                    .toString())
                            .whenComplete(() =>
                                BlocProvider.of<PlanMealBloc>(context).add(
                                    PlanMealLoadData(
                                        dateTime: state.dateTime)));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            child: Row(children: [
                              if (state.foodMealEntity[index].image == "")
                                Container(
                                  height: 80,
                                  width: 80,
                                  color: AppColors.gray,
                                )
                              else
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6)),
                                  child: Image.network(
                                    state.foodMealEntity[index].image,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          MealTag(
                                              meal: StringUtils
                                                  .capitalizeFirstChar(state
                                                      .foodMealEntity[index]
                                                      .meal)),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          FoodTypeTag(
                                              type: StringUtils
                                                  .capitalizeFirstChar(state
                                                      .foodMealEntity[index]
                                                      .type)),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: Text(
                                          state.foodMealEntity[index].name,
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                                  text: "Quantity: ",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: AppColors.black),
                                                  children: <TextSpan>[
                                                TextSpan(
                                                    text: (state
                                                                .foodMealEntity[
                                                                    index]
                                                                .quantity /
                                                            state.member)
                                                        .toStringAsFixed(1),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ])),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          RichText(
                                              text: TextSpan(
                                                  text: "Calories: ",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: AppColors.black),
                                                  children: <TextSpan>[
                                                TextSpan(
                                                    text: (int.parse(state
                                                                .foodMealEntity[
                                                                    index]
                                                                .calories) *
                                                            state
                                                                .foodMealEntity[
                                                                    index]
                                                                .quantity /
                                                            state.member)
                                                        .toStringAsFixed(1),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ])),
                                        ],
                                      ),
                                      buildTrackedComponent(
                                          context, state, index),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          Text(
                                            "Swipe to update dish",
                                            style: TextStyle(
                                                color: AppColors.gray,
                                                fontSize: 12),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      );
    }
    return Container();
  }

  Widget buildNutritionInfo(String title, String value, bool isRemaining) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(color: AppColors.gray),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(value,
            style: TextStyle(
                fontSize: isRemaining ? 18 : 16,
                fontWeight: isRemaining ? FontWeight.bold : FontWeight.normal))
      ],
    );
  }

  Widget buildAddFoodContent(String title, String calories) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.white),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                calories,
                style: GoogleFonts.signika(
                  fontSize: 20,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          addFood(),
        ],
      ),
    );
  }

  Widget addFood() {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: const [
            Expanded(
                child: Text("Add food",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.green,
                    )))
          ],
        ),
      ),
    );
  }

  Widget buildSubmitPlanMealButton(BuildContext context, PlanMealState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(PlanMealRoutes.addFood, arguments: state.dateTime)
                  .whenComplete(() => BlocProvider.of<PlanMealBloc>(context)
                      .add(PlanMealLoadData(dateTime: state.dateTime)));
            },
            child: const Text(
              "Add food",
              style: TextStyle(fontSize: 20),
            ),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.green,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              primary: AppColors.white,
            ),
          ),
        ),
      ]),
    );
  }

  String getDateTime(PlanMealState state) {
    return DateTimeUtils.parseDateTime(state.dateTime);
  }

  String getDateTimeForGroup(PlanMealGroupState state) {
    return DateTimeUtils.parseDateTime(state.dateTime);
  }

  Widget buildPlanMealBodyForGroup(
      BuildContext context, PlanMealGroupState state) {
    if (state is PlanMealGroupLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is PlanMealGroupNoMeal) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/no_item_add.svg"),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have item in list. ",
                style: TextStyle(fontSize: 20),
              ),
              InkWell(
                child: const Text(
                  "Add item",
                  style: TextStyle(fontSize: 20, color: AppColors.green),
                ),
                onTap: () {
                  Map<String, dynamic> args = {
                    'date': state.dateTime,
                    'type': 'group'
                  };
                  Navigator.of(context)
                      .pushNamed(PlanMealRoutes.addFood, arguments: args)
                      .whenComplete(() {
                    BlocProvider.of<PlanMealGroupBloc>(context)
                        .add(PlanMealGroupLoadData(dateTime: state.dateTime));
                    BlocProvider.of<PlanMealBloc>(context)
                        .add(PlanMealLoadData(dateTime: state.dateTime));
                  });
                },
              ),
            ],
          ),
        ],
      );
    } else if (state is PlanMealGroupHasMeal) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Food list",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Map<String, dynamic> args = {
                      'date': state.dateTime,
                      'type': 'group'
                    };
                    Navigator.of(context)
                        .pushNamed(PlanMealRoutes.addFood, arguments: args)
                        .whenComplete(() {
                      BlocProvider.of<PlanMealGroupBloc>(context)
                          .add(PlanMealGroupLoadData(dateTime: state.dateTime));
                      BlocProvider.of<PlanMealBloc>(context)
                          .add(PlanMealLoadData(dateTime: state.dateTime));
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: const Text(
                      "Add +",
                      style: TextStyle(fontSize: 16, color: AppColors.gray),
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
            child: ListView.builder(
                itemCount: state.foodMealEntity.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: ValueKey(index),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.4,
                      children: [
                        SlidableAction(
                          autoClose: false,
                          onPressed: (context) {
                            Navigator.of(context)
                                .pushNamed(PlanMealRoutes.updateFood,
                                    arguments: state.foodMealEntity[index])
                                .whenComplete(() =>
                                    BlocProvider.of<PlanMealGroupBloc>(context)
                                        .add(PlanMealGroupLoadData(
                                            dateTime: state.dateTime)));
                          },
                          backgroundColor: AppColors.blue,
                          foregroundColor: AppColors.white,
                          icon: Icons.edit,
                          label: 'Update',
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            BlocProvider.of<PlanMealGroupBloc>(context).add(
                                PlanMealGroupRemoveDishEvent(
                                    dishId: state
                                        .foodMealEntity[index].foodToMenuId
                                        .toString(),
                                    dateTime: state.dateTime,
                                    meal: state.foodMealEntity[index].meal,
                                    foodMealEntity: state.foodMealEntity));
                          },
                          backgroundColor: AppColors.red,
                          foregroundColor: AppColors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(PlanMealRoutes.foodDetail,
                                arguments: state.foodMealEntity[index].foodId
                                    .toString())
                            .whenComplete(() =>
                                BlocProvider.of<PlanMealGroupBloc>(context).add(
                                    PlanMealGroupLoadData(
                                        dateTime: state.dateTime)));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            child: Row(children: [
                              if (state.foodMealEntity[index].image == "")
                                Container(
                                  height: 80,
                                  width: 80,
                                  color: AppColors.gray,
                                )
                              else
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                  child: Image.network(
                                    state.foodMealEntity[index].image,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          MealTag(
                                              meal: StringUtils
                                                  .capitalizeFirstChar(state
                                                      .foodMealEntity[index]
                                                      .meal)),
                                          // const SizedBox(
                                          //   width: 8,
                                          // ),
                                          // FoodTypeTag(
                                          //     type: state
                                          //         .foodMealEntity[index].type),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: Text(
                                          state.foodMealEntity[index].name,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Quantity: " +
                                                state.foodMealEntity[index]
                                                    .quantity
                                                    .toString(),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Text(
                                              "Calories: ${int.parse(state.foodMealEntity[index].calories) * state.foodMealEntity[index].quantity}"),
                                        ],
                                      ),
                                      buildTrackedComponentForGroup(
                                          context, state, index),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          Text(
                                            "Swipe to update dish",
                                            style: TextStyle(
                                                color: AppColors.gray,
                                                fontSize: 12),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      );
    } else if (state is PlanMealGroupNoGroup) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Seem you don't join any group.",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ],
      );
    }
    return Container();
  }

  Widget buildTrackedComponent(
      BuildContext context, PlanMealState state, int index) {
    if (state is PlanMealHasMeal) {
      return GestureDetector(
        onTap: () {
          BlocProvider.of<PlanMealBloc>(context).add(PlanMealTrackDishEvent(
              index: index,
              dishToMenu: state.foodMealEntity[index].foodToMenuId.toString(),
              dateTime: state.dateTime,
              meal: state.foodMealEntity[index].meal,
              foodMealEntity: state.foodMealEntity,
              tracked: !state.foodMealEntity[index].tracked,
              member: state.member));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              state.foodMealEntity[index].tracked
                  ? SvgPicture.asset(
                      "assets/food/check_circle.svg",
                      height: 24,
                      width: 24,
                    )
                  : SvgPicture.asset(
                      "assets/food/uncheck_circle.svg",
                      height: 24,
                      width: 24,
                    ),
              const SizedBox(
                width: 8,
              ),
              state.foodMealEntity[index].tracked
                  ? const Text(
                      "Uncheck",
                      style: TextStyle(color: AppColors.black, fontSize: 16),
                    )
                  : const Text(
                      "Check",
                      style: TextStyle(color: AppColors.gray, fontSize: 16),
                    )
            ],
          ),
        ),
      );
    }
    return Container();
  }

  Widget buildTrackedComponentForGroup(
      BuildContext context, PlanMealGroupState state, int index) {
    if (state is PlanMealGroupHasMeal) {
      return GestureDetector(
        onTap: () {
          BlocProvider.of<PlanMealGroupBloc>(context).add(
              PlanMealGroupTrackDishEvent(
                  index: index,
                  dishToMenu:
                      state.foodMealEntity[index].foodToMenuId.toString(),
                  dateTime: state.dateTime,
                  meal: state.foodMealEntity[index].meal,
                  foodMealEntity: state.foodMealEntity,
                  tracked: !state.foodMealEntity[index].tracked));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              state.foodMealEntity[index].tracked
                  ? SvgPicture.asset(
                      "assets/food/check_circle.svg",
                      height: 24,
                      width: 24,
                    )
                  : SvgPicture.asset(
                      "assets/food/uncheck_circle.svg",
                      height: 24,
                      width: 24,
                    ),
              const SizedBox(
                width: 8,
              ),
              state.foodMealEntity[index].tracked
                  ? const Text(
                      "Uncheck",
                      style: TextStyle(color: AppColors.black, fontSize: 16),
                    )
                  : const Text(
                      "Check",
                      style: TextStyle(color: AppColors.gray, fontSize: 16),
                    )
            ],
          ),
        ),
      );
    }
    return Container();
  }

  Widget buildDatePickerOption(BuildContext context, PlanMealState state) {
    if (state is PlanMealNoMeal) {
      return GestureDetector(
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: state.dateTime,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            BlocProvider.of<PlanMealBloc>(context).add(
                PlanMealChangeDateEvent(dateTime: newDate ?? DateTime.now()));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text(
              DateTimeUtils.parseDateTime(state.dateTime),
              style: const TextStyle(color: AppColors.white, fontSize: 16),
            ),
          ));
    } else if (state is PlanMealHasMeal) {
      return GestureDetector(
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: state.dateTime,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            BlocProvider.of<PlanMealBloc>(context).add(
                PlanMealChangeDateEvent(dateTime: newDate ?? DateTime.now()));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text(
              DateTimeUtils.parseDateTime(state.dateTime),
              style: const TextStyle(color: AppColors.white, fontSize: 16),
            ),
          ));
    }
    return Container();
  }

  Widget buildDatePickerForGroupOption(
      BuildContext context, PlanMealGroupState state) {
    if (state is PlanMealGroupNoMeal) {
      return GestureDetector(
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: state.dateTime,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            BlocProvider.of<PlanMealGroupBloc>(context).add(
                PlanMealGroupChangeDateEvent(
                    dateTime: newDate ?? DateTime.now()));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text(
              DateTimeUtils.parseDateTime(state.dateTime),
              style: const TextStyle(color: AppColors.white, fontSize: 16),
            ),
          ));
    } else if (state is PlanMealGroupHasMeal) {
      return GestureDetector(
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: state.dateTime,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            BlocProvider.of<PlanMealGroupBloc>(context).add(
                PlanMealGroupChangeDateEvent(
                    dateTime: newDate ?? DateTime.now()));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text(
              DateTimeUtils.parseDateTime(state.dateTime),
              style: const TextStyle(color: AppColors.white, fontSize: 16),
            ),
          ));
    }
    return Container();
  }

  Widget buildDateButton(BuildContext context, PlanMealState state) {
    if (state is PlanMealLoadingState || state is PlanMealInitial) {
      return Container();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                var newDateTime =
                    state.dateTime.subtract(const Duration(days: 1));
                BlocProvider.of<PlanMealBloc>(context)
                    .add(PlanMealChangeDateEvent(dateTime: newDateTime));
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.white,
                size: 16,
              )),
          buildDatePickerOption(context, state),
          GestureDetector(
            onTap: () {
              var newDateTime = state.dateTime.add(const Duration(days: 1));
              BlocProvider.of<PlanMealBloc>(context)
                  .add(PlanMealChangeDateEvent(dateTime: newDateTime));
            },
            child: const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDateButtonForGroup(
      BuildContext context, PlanMealGroupState state) {
    if (state is PlanMealGroupLoadingState || state is PlanMealGroupNoGroup) {
      return Container();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                var newDateTime =
                    state.dateTime.subtract(const Duration(days: 1));
                BlocProvider.of<PlanMealGroupBloc>(context)
                    .add(PlanMealGroupChangeDateEvent(dateTime: newDateTime));
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.white,
                size: 16,
              )),
          buildDatePickerForGroupOption(context, state),
          GestureDetector(
            onTap: () {
              var newDateTime = state.dateTime.add(const Duration(days: 1));
              BlocProvider.of<PlanMealGroupBloc>(context)
                  .add(PlanMealGroupChangeDateEvent(dateTime: newDateTime));
            },
            child: const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
