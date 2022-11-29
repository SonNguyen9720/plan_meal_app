import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/group_user_enity.dart';
import 'package:plan_meal_app/presentation/features/market/groups/groups_bloc.dart';
import 'package:plan_meal_app/presentation/features/market/individual/individual_bloc.dart';
import 'package:plan_meal_app/presentation/widgets/independent/food_type_tag.dart';
import 'package:plan_meal_app/presentation/widgets/independent/scaffold.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PlanMealAppScaffold(
      body: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) => IndividualBloc(
                shoppingListRepository:
                    RepositoryProvider.of<ShoppingListRepository>(context))
              ..add(IndividualLoadingDataEvent(dateTime: DateTime.now()))),
        BlocProvider(
            create: (context) => GroupsBloc(
                  groupRepository:
                      RepositoryProvider.of<GroupRepository>(context),
                )..add(GroupsLoadingEvent())),
      ], child: const MarketScreenWrapper()),
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
              BlocConsumer<IndividualBloc, IndividualState>(
                  listener: (context, individualState) async {
                if (individualState is IndividualWaiting) {
                  EasyLoading.show(
                    status: "Loading ...",
                    maskType: EasyLoadingMaskType.black,
                  );
                } else if (individualState is IndividualFinished) {
                  await EasyLoading.dismiss();
                }
              }, buildWhen: (previousState, state) {
                if (state is IndividualWaiting || state is IndividualFinished) {
                  return false;
                }
                return true;
              }, builder: (context, individualState) {
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
                      buildDatePickerOption(context, individualState),
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
                                  child: const Text(
                                    "Add item",
                                    style: TextStyle(
                                        fontSize: 20, color: AppColors.green),
                                  ),
                                  onTap: () {
                                    var args = {
                                      'dateTime': individualState.dateTime,
                                    };
                                    Navigator.of(context).pushNamed(
                                        PlanMealRoutes.addIngredient,
                                        arguments: args);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                if (individualState is IndividualHasItem) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildDatePickerOption(context, individualState),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Ingredient list",
                              style: TextStyle(fontSize: 18),
                            ),
                            GestureDetector(
                              onTap: () {
                                var args = {
                                  'dateTime': individualState.dateTime,
                                };
                                Navigator.of(context).pushNamed(
                                    PlanMealRoutes.addIngredient,
                                    arguments: args);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: const Text(
                                  "Add +",
                                  style: TextStyle(
                                      fontSize: 16, color: AppColors.gray),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: AppColors.gray),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: buildListIngredient(context, individualState)),
                    ],
                  );
                }
                return const Text("No state to handle");
              }),
              BlocBuilder<GroupsBloc, GroupsState>(builder: (context, state) {
                if (state is GroupsLoading) {
                  return const Center(
                      child: SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator()));
                } else if (state is GroupsLoadFailed) {
                  return const Text("Failed to loading");
                } else if (state is NoGroup) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 175,
                        width: 175,
                        child: Image.asset(
                          "assets/groups.png",
                          color: AppColors.gray,
                        ),
                      ),
                      Text(
                        "Don't have any group",
                        style: GoogleFonts.signika(fontSize: 20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Text(
                              "Create a group",
                              style: GoogleFonts.signika(
                                  fontSize: 20, color: AppColors.green),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(PlanMealRoutes.addGroup);
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (state is HaveGroup) {
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                                state.groupUserList.length,
                                (index) =>
                                    buildItemGroup(index, state.groupUserList)),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(PlanMealRoutes.addGroup);
                            },
                            child: const Text(
                              "Create a group",
                              style: TextStyle(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.green,
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                }
                return const Text("No state to handle");
              }),
            ],
          ),
        )),
      ],
    );
  }

  Widget buildItemGroup(index, List<GroupUserEntity> groupUserList) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, PlanMealRoutes.groupDetail, arguments: {
          'groupName': groupUserList[index].groupName,
          'groupId': groupUserList[index].groupId
        });
      },
      child: Row(
        children: [
          Expanded(
            child: Card(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupUserList[index].groupName,
                      style: const TextStyle(fontSize: 24),
                    ),
                    Text(
                      "Number of member: ${groupUserList[index].number}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListIngredient(BuildContext context, IndividualHasItem state) {
    return ListView.builder(
        itemCount: state.listIngredient.length,
        itemBuilder: (context, index) {
          return Slidable(
            key: ValueKey(index),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.2,
              children: [
                SlidableAction(
                  onPressed: (context) {
                    BlocProvider.of<IndividualBloc>(context).add(
                        IndividualRemoveIngredientEvent(
                            date: state.dateTime,
                            ingredient: state.listIngredient[index],
                            listIngredient: state.listIngredient));
                  },
                  backgroundColor: AppColors.red,
                  foregroundColor: AppColors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                )
              ],
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(children: [
                    if (state.listIngredient[index].imageUrl == "")
                      Image.asset(
                        "assets/ingredient/ingredients_default.png",
                        height: 80,
                        width: 80,
                      )
                    else
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        child: Image.network(
                          state.listIngredient[index].imageUrl,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                FoodTypeTag(
                                    type: state.listIngredient[index].type),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                state.listIngredient[index].name,
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
                                      state.listIngredient[index].quantity
                                          .toString(),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                              ],
                            ),
                            // buildTrackedComponent(context, state, index),
                          ],
                        ),
                      ),
                    ),
                    Checkbox(
                        value: state.listIngredient[index].checked,
                        onChanged: (value) {
                          BlocProvider.of<IndividualBloc>(context).add(
                              IndividualUpdateIngredientEvent(
                                  date: state.dateTime,
                                  listIngredient: state.listIngredient,
                                  index: index,
                                  ingredient: state.listIngredient[index],
                                  value: value!));
                        })
                  ]),
                ),
              ),
            ),
          );
        });
  }

  Widget buildDatePickerOption(BuildContext context, IndividualState state) {
    if (state is IndividualNoItem) {
      return ElevatedButton(
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            BlocProvider.of<IndividualBloc>(context).add(
                IndividualChangeDateEvent(dateTime: newDate ?? DateTime.now()));
          },
          child: Text(DateTimeUtils.parseDateTime(state.dateTime)),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            primary: AppColors.green,
          ));
    } else if (state is IndividualHasItem) {
      return ElevatedButton(
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            BlocProvider.of<IndividualBloc>(context).add(
                IndividualChangeDateEvent(dateTime: newDate ?? DateTime.now()));
          },
          child: Text(DateTimeUtils.parseDateTime(state.dateTime)),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            primary: AppColors.green,
          ));
    }
    return Container();
  }
}
