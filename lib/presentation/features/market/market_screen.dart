import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/model/measurement_model.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/ingredient_detail_entity.dart';
import 'package:plan_meal_app/domain/entities/location_entity.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';
import 'package:plan_meal_app/domain/string_utils.dart';
import 'package:plan_meal_app/presentation/features/market/groups/groups_bloc.dart';
import 'package:plan_meal_app/presentation/features/market/individual/individual_bloc.dart';
import 'package:plan_meal_app/presentation/features/market/marketer/marketer_bloc.dart';
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
                IndividualBloc(
                    shoppingListRepository:
                    RepositoryProvider.of<ShoppingListRepository>(context))
                  ..add(IndividualLoadingDataEvent(
                      dateStart: DateTime.now(), dateEnd: DateTime.now()))),
            BlocProvider(
                create: (context) =>
                GroupsBloc(
                  shoppingListRepository:
                  RepositoryProvider.of<ShoppingListRepository>(context),
                )
                  ..add(GroupLoadingDataEvent(
                      dateStart: DateTime.now(), dateEnd: DateTime.now()))),
            BlocProvider(
                create: (context) =>
                MarketerBloc(
                    shoppingListRepository:
                    RepositoryProvider.of<ShoppingListRepository>(context))
                  ..add(MarketerLoadEvent(
                      groupId: PreferenceUtils.getString("groupId")!,
                      date: DateTime.now())))
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

  List<bool> data = List.filled(9999, false);

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
                    if (state is IndividualWaiting ||
                        state is IndividualFinished) {
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
                          buildRangePicker(context, individualState),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8),
                          //   decoration: BoxDecoration(
                          //     color: AppColors.green,
                          //     borderRadius: BorderRadius.circular(6),
                          //   ),
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       GestureDetector(
                          //           onTap: () {
                          //             // var newDateTime = individualState.dateTime
                          //             //     .subtract(const Duration(days: 1));
                          //             // BlocProvider.of<IndividualBloc>(context)
                          //             //     .add(
                          //             //     IndividualChangeDateEvent(
                          //             //         dateTime: newDateTime));
                          //           },
                          //           child: const Icon(
                          //             Icons.arrow_back_ios,
                          //             color: AppColors.white,
                          //             size: 16,
                          //           )),
                          //       buildDatePickerOption(context, individualState),
                          //       GestureDetector(
                          //         onTap: () {
                          //           // var newDateTime = individualState.dateTime
                          //           //     .add(const Duration(days: 1));
                          //           // BlocProvider.of<IndividualBloc>(context)
                          //           //     .add(
                          //           //     IndividualChangeDateEvent(
                          //           //         dateTime: newDateTime));
                          //         },
                          //         child: const Icon(
                          //           Icons.arrow_forward_ios,
                          //           color: AppColors.white,
                          //           size: 16,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Expanded(
                            child: Column(
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
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.green),
                                      ),
                                      onTap: () {
                                        var args = {
                                          'dateTime': DateTime.now(),
                                          'type': "individual",
                                        };
                                        Navigator.of(context)
                                            .pushNamed(
                                            PlanMealRoutes.addIngredient,
                                            arguments: args)
                                            .whenComplete(() =>
                                            BlocProvider.of<IndividualBloc>(
                                                context)
                                                .add(IndividualLoadingDataEvent(
                                              dateStart:
                                              individualState.dateStart,
                                              dateEnd: individualState.dateEnd,
                                            )));
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
                          buildRangePicker(context, individualState),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Ingredient list",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    var args = {
                                      'dateTime': DateTime.now(),
                                      'type': "individual"
                                    };
                                    Navigator.of(context)
                                        .pushNamed(PlanMealRoutes.addIngredient,
                                        arguments: args)
                                        .whenComplete(() =>
                                        BlocProvider.of<IndividualBloc>(context)
                                            .add(IndividualLoadingDataEvent(
                                          dateStart: individualState.dateStart,
                                          dateEnd: individualState.dateEnd,
                                        )));
                                  },
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
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.5,
                            child: SingleChildScrollView(
                                child:
                                buildListIngredient(context, individualState)),
                          ),
                        ],
                      );
                    }
                    return const Text("No state to handle");
                  }),
                  BlocConsumer<GroupsBloc, GroupsState>(
                      listener: (context, groupState) async {
                        if (groupState is GroupWaiting) {
                          EasyLoading.show(
                            status: "Loading ...",
                            maskType: EasyLoadingMaskType.black,
                          );
                        } else if (groupState is GroupFinished) {
                          await EasyLoading.dismiss();
                        }
                      }, buildWhen: (previousState, state) {
                    if (state is GroupWaiting || state is GroupFinished) {
                      return false;
                    }
                    return true;
                  }, builder: (context, groupState) {
                    if (groupState is GroupLoadingItem) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (groupState is GroupLoadFailed) {
                      return const Center(
                        child: Text("Load data failed"),
                      );
                    }
                    if (groupState is GroupNoItem) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildRangePickerForGroup(context, groupState),
                          Expanded(
                            child: Column(
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
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: AppColors.green),
                                      ),
                                      onTap: () {
                                        var args = {
                                          'dateTime': DateTime.now(),
                                          'type': 'group'
                                        };
                                        Navigator.of(context)
                                            .pushNamed(
                                            PlanMealRoutes.addIngredient,
                                            arguments: args)
                                            .whenComplete(() =>
                                            BlocProvider.of<GroupsBloc>(context)
                                                .add(GroupLoadingDataEvent(
                                                dateStart: DateTime.now(),
                                                dateEnd: DateTime.now())));
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
                    if (groupState is GroupHasItem) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildRangePickerForGroup(context, groupState),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Ingredient list",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    var args = {
                                      'dateTime': DateTime.now(),
                                      'type': 'group'
                                    };
                                    Navigator.of(context)
                                        .pushNamed(PlanMealRoutes.addIngredient,
                                        arguments: args)
                                        .whenComplete(() =>
                                        BlocProvider.of<GroupsBloc>(context)
                                            .add(GroupLoadingDataEvent(
                                            dateStart: DateTime.now(),
                                            dateEnd: DateTime.now())));
                                  },
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
                          // buildMarketFunction(context, groupState.dateTime),
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.5,
                            child: SingleChildScrollView(
                                child:
                                buildListIngredientForGroup(
                                    context, groupState)),
                          ),
                        ],
                      );
                    }
                    if (groupState is GroupNoGroup) {
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
                    return const Text("No state to handle");
                  }),
                ],
              ),
            )),
      ],
    );
  }

  // Widget buildItemGroup(index, List<GroupUserEntity> groupUserList) {
  //   return InkWell(
  //     onTap: () {
  //       Navigator.pushNamed(context, PlanMealRoutes.groupDetail, arguments: {
  //         'groupName': groupUserList[index].groupName,
  //         'groupId': groupUserList[index].groupId
  //       });
  //     },
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Card(
  //             child: Container(
  //               padding:
  //                   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
  //               margin: const EdgeInsets.symmetric(vertical: 8.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     groupUserList[index].groupName,
  //                     style: const TextStyle(fontSize: 24),
  //                   ),
  //                   Text(
  //                     "Number of member: ${groupUserList[index].number}",
  //                     style: const TextStyle(fontSize: 16),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget buildListIngredient(BuildContext context, IndividualHasItem state) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          data[index] = !isExpanded;
        });
      },
      dividerColor: AppColors.green,
      children:
      List.generate(state.listIngredient.length, (indexIngredientByDay) {
        return ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text(state.listIngredient[indexIngredientByDay].name!),
              );
            },
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  state
                      .listIngredient[indexIngredientByDay]
                      .ingredientCategories!
                      .length, (indexIngredientCategories) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    state
                        .listIngredient[indexIngredientByDay]
                        .ingredientCategories![indexIngredientCategories]
                        .ingredients!
                        .isNotEmpty
                        ? Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: Text(
                        state
                            .listIngredient[indexIngredientByDay]
                            .ingredientCategories![
                        indexIngredientCategories]
                            .name!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                        : Container(),
                    ...List.generate(
                        state
                            .listIngredient[indexIngredientByDay]
                            .ingredientCategories![indexIngredientCategories]
                            .ingredients!
                            .length, (indexIngredients) {
                      return GestureDetector(
                        onTap: () {
                          Map<String, dynamic> args = {
                            'ingredientId': state
                                .listIngredient[indexIngredientByDay]
                                .ingredientCategories![
                            indexIngredientCategories]
                                .ingredients![indexIngredients]
                                .ingredient!.id
                                .toString(),
                            'name': state
                                .listIngredient[indexIngredientByDay]
                                .ingredientCategories![
                            indexIngredientCategories]
                                .ingredients![indexIngredients]
                                .ingredient!
                                .name!,
                            'imageUrl': state
                                .listIngredient[indexIngredientByDay]
                                .ingredientCategories![
                            indexIngredientCategories]
                                .ingredients![indexIngredients]
                                .ingredient!
                                .imageUrl!,

                          };
                          Navigator.of(context).pushNamed(
                              PlanMealRoutes.ingredientDetail, arguments: args);
                        },
                        child: Slidable(
                          key: ValueKey(indexIngredients +
                              indexIngredientCategories * indexIngredientByDay),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.4,
                            children: [
                              SlidableAction(
                                autoClose: false,
                                onPressed: (context) {
                                  IngredientDetailEntity ingredient =
                                  IngredientDetailEntity(
                                    ingredientId: state
                                        .listIngredient[indexIngredientByDay]
                                        .ingredientCategories![
                                    indexIngredientCategories]
                                        .ingredients![indexIngredients]
                                        .ingredientToShoppingListId
                                        .toString(),
                                    name: state
                                        .listIngredient[indexIngredientByDay]
                                        .ingredientCategories![
                                    indexIngredientCategories]
                                        .ingredients![indexIngredients]
                                        .ingredient!
                                        .name!,
                                    calories: 0,
                                    imageUrl: state
                                        .listIngredient[indexIngredientByDay]
                                        .ingredientCategories![
                                    indexIngredientCategories]
                                        .ingredients![indexIngredients]
                                        .ingredient!
                                        .imageUrl!,
                                    measurementType: MeasurementModel(
                                        measurement: state
                                            .listIngredient[
                                        indexIngredientByDay]
                                            .ingredientCategories![
                                        indexIngredientCategories]
                                            .ingredients![indexIngredients]
                                            .measurementType!
                                            .name!,
                                        id: state
                                            .listIngredient[
                                        indexIngredientByDay]
                                            .ingredientCategories![
                                        indexIngredientCategories]
                                            .ingredients![indexIngredients]
                                            .measurementType!
                                            .id
                                            .toString()),
                                    quantity: state
                                        .listIngredient[indexIngredientByDay]
                                        .ingredientCategories![
                                    indexIngredientCategories]
                                        .ingredients![indexIngredients]
                                        .quantity!,
                                    location: LocationEntity(
                                        id: state
                                            .listIngredient[
                                        indexIngredientByDay]
                                            .ingredientCategories![
                                        indexIngredientCategories]
                                            .ingredients![indexIngredients]
                                            .location
                                            ?.id
                                            .toString() ??
                                            "",
                                        location: state
                                            .listIngredient[
                                        indexIngredientByDay]
                                            .ingredientCategories![
                                        indexIngredientCategories]
                                            .ingredients![indexIngredients]
                                            .location
                                            ?.name ??
                                            ""),
                                    note: state
                                        .listIngredient[indexIngredientByDay]
                                        .ingredientCategories![
                                    indexIngredientCategories]
                                        .ingredients![indexIngredients]
                                        .note!,
                                  );
                                  Navigator.of(context)
                                      .pushNamed(
                                      PlanMealRoutes.updateIngredient,
                                      arguments: ingredient)
                                      .whenComplete(() =>
                                      BlocProvider.of<IndividualBloc>(
                                          context)
                                          .add(IndividualLoadingDataEvent(
                                        dateStart: state.dateStart,
                                        dateEnd: state.dateEnd,
                                      )));
                                },
                                backgroundColor: AppColors.blue,
                                foregroundColor: AppColors.white,
                                icon: Icons.edit,
                                label: 'Update',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  BlocProvider.of<IndividualBloc>(context).add(
                                      IndividualRemoveIngredientEvent(
                                          ingredient: state
                                              .listIngredient[
                                          indexIngredientByDay]
                                              .ingredientCategories![
                                          indexIngredientCategories]
                                              .ingredients![indexIngredients],
                                          listIngredient: state.listIngredient,
                                          dateStart: state.dateStart,
                                          dateEnd: state.dateEnd,
                                          indexIngredientCategories:
                                          indexIngredientCategories,
                                          indexIngredients: indexIngredients,
                                          indexIngredientByDay:
                                          indexIngredientByDay));
                                },
                                backgroundColor: AppColors.red,
                                foregroundColor: AppColors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16),
                                child: Column(
                                  children: [
                                    Row(children: [
                                      if (state
                                          .listIngredient[
                                      indexIngredientByDay]
                                          .ingredientCategories![
                                      indexIngredientCategories]
                                          .ingredients![indexIngredients]
                                          .ingredient!
                                          .imageUrl! ==
                                          "")
                                        Image.asset(
                                          "assets/ingredient/ingredients_default.png",
                                          height: 64,
                                          width: 64,
                                        )
                                      else
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6)),
                                          child: Image.network(
                                            state
                                                .listIngredient[
                                            indexIngredientByDay]
                                                .ingredientCategories![
                                            indexIngredientCategories]
                                                .ingredients![indexIngredients]
                                                .ingredient!
                                                .imageUrl!,
                                            height: 64,
                                            width: 64,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                const EdgeInsets.symmetric(
                                                    vertical: 4),
                                                child: Text(
                                                  state
                                                      .listIngredient[
                                                  indexIngredientByDay]
                                                      .ingredientCategories![
                                                  indexIngredientCategories]
                                                      .ingredients![
                                                  indexIngredients]
                                                      .ingredient!
                                                      .name!,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                const EdgeInsets.symmetric(
                                                    vertical: 4),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "Quantity: ${state
                                                            .listIngredient[indexIngredientByDay]
                                                            .ingredientCategories![indexIngredientCategories]
                                                            .ingredients![indexIngredients]
                                                            .quantity} ${StringUtils
                                                            .parseString(state
                                                            .listIngredient[indexIngredientByDay]
                                                            .ingredientCategories![indexIngredientCategories]
                                                            .ingredients![indexIngredients]
                                                            .measurementType!
                                                            .name!)}",
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              state
                                                  .listIngredient[
                                              indexIngredientByDay]
                                                  .ingredientCategories![
                                              indexIngredientCategories]
                                                  .ingredients![
                                              indexIngredients]
                                                  .note!
                                                  .isNotEmpty
                                                  ? Container(
                                                margin: const EdgeInsets
                                                    .symmetric(
                                                    vertical: 4),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "Note: ${state
                                                            .listIngredient[indexIngredientByDay]
                                                            .ingredientCategories![indexIngredientCategories]
                                                            .ingredients![indexIngredients]
                                                            .note!}",
                                                        style:
                                                        const TextStyle(
                                                            fontSize:
                                                            14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                                  : Container(),
                                              // buildTrackedComponent(context, state, index),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Checkbox(
                                          shape: const CircleBorder(),
                                          value: state
                                              .listIngredient[
                                          indexIngredientByDay]
                                              .ingredientCategories![
                                          indexIngredientCategories]
                                              .ingredients![indexIngredients]
                                              .checked,
                                          fillColor:
                                          MaterialStateProperty.resolveWith(
                                              getColor),
                                          onChanged: (value) {
                                            BlocProvider.of<IndividualBloc>(
                                                context)
                                                .add(
                                                IndividualUpdateIngredientEvent(
                                                    dateStart: state.dateStart,
                                                    listIngredient:
                                                    state.listIngredient,
                                                    value: value!,
                                                    dateEnd: state.dateEnd,
                                                    ingredient: state
                                                        .listIngredient[
                                                    indexIngredientByDay]
                                                        .ingredientCategories![
                                                    indexIngredientCategories]
                                                        .ingredients![
                                                    indexIngredients],
                                                    indexIngredientByDay:
                                                    indexIngredientByDay,
                                                    indexIngredients:
                                                    indexIngredients,
                                                    indexIngredientCategories:
                                                    indexIngredientCategories));
                                          })
                                    ]),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Text(
                                          "Swipe to update",
                                          style: TextStyle(
                                              color: AppColors.gray,
                                              fontSize: 10),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              }),
            ),
            isExpanded: data[indexIngredientByDay]);
      }),
    );
    // return ListView.builder(
    //     itemCount: state.listIngredient.length,
    //     itemBuilder: (context, index) {
    //       // return GestureDetector(
    //       //   onTap: () {},
    //       //   child: Slidable(
    //       //     key: ValueKey(index),
    //       //     endActionPane: ActionPane(
    //       //       motion: const ScrollMotion(),
    //       //       extentRatio: 0.4,
    //       //       children: [
    //       //         SlidableAction(
    //       //           autoClose: false,
    //       //           onPressed: (context) {
    //       //             IngredientDetailEntity ingredient =
    //       //                 IngredientDetailEntity(
    //       //               ingredientId: state
    //       //                   .listIngredient[index].ingredientIdToShoppingList,
    //       //               name: state.listIngredient[index].name,
    //       //               calories: 0,
    //       //               imageUrl: state.listIngredient[index].imageUrl,
    //       //               measurementType:
    //       //                   state.listIngredient[index].measurement,
    //       //               quantity: state.listIngredient[index].quantity,
    //       //               location: state.listIngredient[index].location,
    //       //                   note: state.listIngredient[index].note,
    //       //             );
    //       //             Navigator.of(context)
    //       //                 .pushNamed(PlanMealRoutes.updateIngredient,
    //       //                     arguments: ingredient)
    //       //                 .whenComplete(() =>
    //       //                     BlocProvider.of<IndividualBloc>(context)
    //       //                         .add(IndividualLoadingDataEvent(
    //       //                       dateStart: state.dateStart,
    //       //                       dateEnd: state.dateEnd,
    //       //                     )));
    //       //           },
    //       //           backgroundColor: AppColors.blue,
    //       //           foregroundColor: AppColors.white,
    //       //           icon: Icons.edit,
    //       //           label: 'Update',
    //       //         ),
    //       //         SlidableAction(
    //       //           onPressed: (context) {
    //       //             BlocProvider.of<IndividualBloc>(context).add(
    //       //                 IndividualRemoveIngredientEvent(
    //       //                     ingredient: state.listIngredient[index],
    //       //                     listIngredient: state.listIngredient,
    //       //                     dateStart: state.dateStart,
    //       //                     dateEnd: state.dateEnd));
    //       //           },
    //       //           backgroundColor: AppColors.red,
    //       //           foregroundColor: AppColors.white,
    //       //           icon: Icons.delete,
    //       //           label: 'Delete',
    //       //         ),
    //       //       ],
    //       //     ),
    //       //     child: Container(
    //       //       margin: const EdgeInsets.symmetric(horizontal: 8),
    //       //       child: Card(
    //       //         shape: const RoundedRectangleBorder(
    //       //             borderRadius: BorderRadius.all(Radius.circular(6))),
    //       //         child: Padding(
    //       //           padding: const EdgeInsets.symmetric(
    //       //               vertical: 16, horizontal: 16),
    //       //           child: Column(
    //       //             children: [
    //       //               Row(children: [
    //       //                 if (state.listIngredient[index].imageUrl == "")
    //       //                   Image.asset(
    //       //                     "assets/ingredient/ingredients_default.png",
    //       //                     height: 64,
    //       //                     width: 64,
    //       //                   )
    //       //                 else
    //       //                   ClipRRect(
    //       //                     borderRadius:
    //       //                         const BorderRadius.all(Radius.circular(6)),
    //       //                     child: Image.network(
    //       //                       state.listIngredient[index].imageUrl,
    //       //                       height: 64,
    //       //                       width: 64,
    //       //                       fit: BoxFit.cover,
    //       //                     ),
    //       //                   ),
    //       //                 Expanded(
    //       //                   child: Padding(
    //       //                     padding:
    //       //                         const EdgeInsets.symmetric(horizontal: 20),
    //       //                     child: Column(
    //       //                       mainAxisAlignment: MainAxisAlignment.start,
    //       //                       crossAxisAlignment: CrossAxisAlignment.start,
    //       //                       children: [
    //       //                         Row(
    //       //                           children: [
    //       //                             FoodTypeTag(
    //       //                                 type: StringUtils.capitalizeFirstChar(
    //       //                                     state
    //       //                                         .listIngredient[index].type)),
    //       //                           ],
    //       //                         ),
    //       //                         Container(
    //       //                           margin:
    //       //                               const EdgeInsets.symmetric(vertical: 4),
    //       //                           child: Text(
    //       //                             state.listIngredient[index].name,
    //       //                             style: const TextStyle(
    //       //                               fontSize: 20,
    //       //                               fontWeight: FontWeight.w700,
    //       //                             ),
    //       //                           ),
    //       //                         ),
    //       //                         Container(
    //       //                           margin:
    //       //                               const EdgeInsets.symmetric(vertical: 4),
    //       //                           child: Row(
    //       //                             children: [
    //       //                               Expanded(
    //       //                                 child: Text(
    //       //                                   "Quantity: ${state.listIngredient[index].quantity} ${StringUtils.parseString(state.listIngredient[index].measurement.measurement)}",
    //       //                                   style:
    //       //                                       const TextStyle(fontSize: 14),
    //       //                                 ),
    //       //                               ),
    //       //                             ],
    //       //                           ),
    //       //                         ),
    //       //                         state.listIngredient[index].location.location
    //       //                                 .isNotEmpty
    //       //                             ? Container(
    //       //                                 margin: const EdgeInsets.symmetric(
    //       //                                     vertical: 4),
    //       //                                 child: Row(
    //       //                                   children: [
    //       //                                     Expanded(
    //       //                                       child: Text(
    //       //                                         "Location: ${state.listIngredient[index].location.location}",
    //       //                                         style: const TextStyle(
    //       //                                             fontSize: 14),
    //       //                                       ),
    //       //                                     ),
    //       //                                   ],
    //       //                                 ),
    //       //                               )
    //       //                             : Container(),
    //       //                         state.listIngredient[index].note.isNotEmpty
    //       //                             ? Container(
    //       //                                 margin: const EdgeInsets.symmetric(
    //       //                                     vertical: 4),
    //       //                                 child: Row(
    //       //                                   children: [
    //       //                                     Expanded(
    //       //                                       child: Text(
    //       //                                         "Note: ${state.listIngredient[index].note}",
    //       //                                         style: const TextStyle(
    //       //                                             fontSize: 14),
    //       //                                       ),
    //       //                                     ),
    //       //                                   ],
    //       //                                 ),
    //       //                               )
    //       //                             : Container(),
    //       //                         // buildTrackedComponent(context, state, index),
    //       //                       ],
    //       //                     ),
    //       //                   ),
    //       //                 ),
    //       //                 Checkbox(
    //       //                     shape: const CircleBorder(),
    //       //                     value: state.listIngredient[index].checked,
    //       //                     fillColor:
    //       //                         MaterialStateProperty.resolveWith(getColor),
    //       //                     onChanged: (value) {
    //       //                       BlocProvider.of<IndividualBloc>(context).add(
    //       //                           IndividualUpdateIngredientEvent(
    //       //                               dateStart: state.dateStart,
    //       //                               listIngredient: state.listIngredient,
    //       //                               index: index,
    //       //                               ingredient: state.listIngredient[index],
    //       //                               value: value!,
    //       //                               dateEnd: state.dateEnd));
    //       //                     })
    //       //               ]),
    //       //               Row(
    //       //                 mainAxisAlignment: MainAxisAlignment.end,
    //       //                 children: const [
    //       //                   Text(
    //       //                     "Swipe to update",
    //       //                     style: TextStyle(
    //       //                         color: AppColors.gray, fontSize: 10),
    //       //                   ),
    //       //                 ],
    //       //               )
    //       //             ],
    //       //           ),
    //       //         ),
    //       //       ),
    //       //     ),
    //       //   ),
    //       // );
    //     });
  }

  Widget buildDatePickerOption(BuildContext context, IndividualState state) {
    if (state is IndividualNoItem) {
      return GestureDetector(
        onTap: () async {
          // DateTime? newDate = await showDatePicker(
          //     context: context,
          //     initialDate: state.dateTime,
          //     firstDate: DateTime(1900),
          //     lastDate: DateTime(2100));
          // BlocProvider.of<IndividualBloc>(context).add(
          //     IndividualChangeDateEvent(dateTime: newDate ?? DateTime.now()));
        },
        // child: Container(
        //   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        //   child: Text(
        //     DateTimeUtils.parseDateTime(state.dateTime),
        //     style: const TextStyle(color: AppColors.white, fontSize: 16),
        //   ),
        // ),
      );
    } else if (state is IndividualHasItem) {
      return GestureDetector(
        onTap: () async {
          // DateTime? newDate = await showDatePicker(
          //     context: context,
          //     initialDate: state.dateTime,
          //     firstDate: DateTime(1900),
          //     lastDate: DateTime(2100));
          // BlocProvider.of<IndividualBloc>(context).add(
          //     IndividualChangeDateEvent(dateTime: newDate ?? DateTime.now()));
        },
        // child: Container(
        //   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        //   child: Text(
        //     DateTimeUtils.parseDateTime(state.dateTime),
        //     style: const TextStyle(color: AppColors.white, fontSize: 16),
        //   ),
        // ),
      );
    }
    return Container();
  }

  Widget buildDatePickerForGroupOption(BuildContext context,
      GroupsState state) {
    if (state is GroupNoItem) {
      // return GestureDetector(
      //   onTap: () async {
      //     DateTime? newDate = await showDatePicker(
      //         context: context,
      //         initialDate: state.dateTime,
      //         firstDate: DateTime(1900),
      //         lastDate: DateTime(2100));
      //     String groupId = PreferenceUtils.getString("groupId")!;
      //     BlocProvider.of<MarketerBloc>(context).add(MarketerLoadEvent(
      //         groupId: groupId, date: newDate ?? DateTime.now()));
      //     BlocProvider.of<GroupsBloc>(context)
      //         .add(GroupChangeDateEvent(dateTime: newDate ?? DateTime.now()));
      //   },
      //   child: Container(
      //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      //     child: Text(
      //       DateTimeUtils.parseDateTime(state.dateTime),
      //       style: const TextStyle(color: AppColors.white, fontSize: 16),
      //     ),
      //   ),
      // );
    } else if (state is GroupHasItem) {
      // return GestureDetector(
      //   onTap: () async {
      //     DateTime? newDate = await showDatePicker(
      //         context: context,
      //         initialDate: state.dateTime,
      //         firstDate: DateTime(1900),
      //         lastDate: DateTime(2100));
      //     BlocProvider.of<GroupsBloc>(context)
      //         .add(GroupChangeDateEvent(dateTime: newDate ?? DateTime.now()));
      //   },
      //   child: Container(
      //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      //     child: Text(
      //       DateTimeUtils.parseDateTime(state.dateTime),
      //       style: const TextStyle(color: AppColors.white, fontSize: 16),
      //     ),
      //   ),
      // );
    }
    return Container();
  }

  Widget buildListIngredientForGroup(BuildContext context, GroupHasItem state) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          data[index] = !isExpanded;
        });
      },
      dividerColor: AppColors.green,
      elevation: 0,
      children:
      List.generate(state.listIngredient.length, (indexIngredientByDay) {
        return ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text(state.listIngredient[indexIngredientByDay].name!),
              );
            },
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  state
                      .listIngredient[indexIngredientByDay]
                      .ingredientCategories!
                      .length, (indexIngredientCategories) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    state
                        .listIngredient[indexIngredientByDay]
                        .ingredientCategories![indexIngredientCategories]
                        .ingredients!
                        .isNotEmpty
                        ? Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: Text(
                        state
                            .listIngredient[indexIngredientByDay]
                            .ingredientCategories![
                        indexIngredientCategories]
                            .name!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                        : Container(),
                    ...List.generate(
                        state
                            .listIngredient[indexIngredientByDay]
                            .ingredientCategories![indexIngredientCategories]
                            .ingredients!
                            .length, (indexIngredients) {
                      return GestureDetector(
                        onTap: () {
                          Map<String, dynamic> args = {
                            'ingredientId': state
                                .listIngredient[indexIngredientByDay]
                                .ingredientCategories![
                            indexIngredientCategories]
                                .ingredients![indexIngredients]
                                .ingredient!.id
                                .toString(),
                            'name': state
                                .listIngredient[indexIngredientByDay]
                                .ingredientCategories![
                            indexIngredientCategories]
                                .ingredients![indexIngredients]
                                .ingredient!
                                .name!,
                            'imageUrl': state
                                .listIngredient[indexIngredientByDay]
                                .ingredientCategories![
                            indexIngredientCategories]
                                .ingredients![indexIngredients]
                                .ingredient!
                                .imageUrl!,

                          };
                          Navigator.of(context).pushNamed(
                              PlanMealRoutes.ingredientDetail, arguments: args);
                        },
                        child: Slidable(
                          key: ValueKey(indexIngredients +
                              indexIngredientCategories * indexIngredientByDay),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.4,
                            children: [
                              SlidableAction(
                                autoClose: false,
                                onPressed: (context) {
                                  IngredientDetailEntity ingredient =
                                  IngredientDetailEntity(
                                    ingredientId: state
                                        .listIngredient[indexIngredientByDay]
                                        .ingredientCategories![
                                    indexIngredientCategories]
                                        .ingredients![indexIngredients]
                                        .ingredientToShoppingListId
                                        .toString(),
                                    name: state
                                        .listIngredient[indexIngredientByDay]
                                        .ingredientCategories![
                                    indexIngredientCategories]
                                        .ingredients![indexIngredients]
                                        .ingredient!
                                        .name!,
                                    calories: 0,
                                    imageUrl: state
                                        .listIngredient[indexIngredientByDay]
                                        .ingredientCategories![
                                    indexIngredientCategories]
                                        .ingredients![indexIngredients]
                                        .ingredient!
                                        .imageUrl!,
                                    measurementType: MeasurementModel(
                                        measurement: state
                                            .listIngredient[
                                        indexIngredientByDay]
                                            .ingredientCategories![
                                        indexIngredientCategories]
                                            .ingredients![indexIngredients]
                                            .measurementType!
                                            .name!,
                                        id: state
                                            .listIngredient[
                                        indexIngredientByDay]
                                            .ingredientCategories![
                                        indexIngredientCategories]
                                            .ingredients![indexIngredients]
                                            .measurementType!
                                            .id
                                            .toString()),
                                    quantity: state
                                        .listIngredient[indexIngredientByDay]
                                        .ingredientCategories![
                                    indexIngredientCategories]
                                        .ingredients![indexIngredients]
                                        .quantity!,
                                    location: LocationEntity(
                                        id: state
                                            .listIngredient[
                                        indexIngredientByDay]
                                            .ingredientCategories![
                                        indexIngredientCategories]
                                            .ingredients![indexIngredients]
                                            .location
                                            ?.id
                                            .toString() ??
                                            "",
                                        location: state
                                            .listIngredient[
                                        indexIngredientByDay]
                                            .ingredientCategories![
                                        indexIngredientCategories]
                                            .ingredients![indexIngredients]
                                            .location
                                            ?.name ??
                                            ""),
                                    note: state
                                        .listIngredient[indexIngredientByDay]
                                        .ingredientCategories![
                                    indexIngredientCategories]
                                        .ingredients![indexIngredients]
                                        .note!,
                                  );
                                  Navigator.of(context)
                                      .pushNamed(
                                      PlanMealRoutes.updateIngredient,
                                      arguments: ingredient)
                                      .whenComplete(() =>
                                      BlocProvider.of<GroupsBloc>(context)
                                          .add(GroupLoadingDataEvent(
                                        dateStart: state.dateStart,
                                        dateEnd: state.dateEnd,
                                      )));
                                },
                                backgroundColor: AppColors.blue,
                                foregroundColor: AppColors.white,
                                icon: Icons.edit,
                                label: 'Update',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  BlocProvider.of<GroupsBloc>(context).add(
                                      GroupRemoveIngredientEvent(
                                          ingredient: state
                                              .listIngredient[
                                          indexIngredientByDay]
                                              .ingredientCategories![
                                          indexIngredientCategories]
                                              .ingredients![indexIngredients],
                                          listIngredient: state.listIngredient,
                                          dateStart: state.dateStart,
                                          dateEnd: state.dateEnd,
                                          indexIngredientCategories:
                                          indexIngredientCategories,
                                          indexIngredients: indexIngredients,
                                          indexIngredientByDay:
                                          indexIngredientByDay));
                                },
                                backgroundColor: AppColors.red,
                                foregroundColor: AppColors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16),
                                child: Column(
                                  children: [
                                    Row(children: [
                                      if (state
                                          .listIngredient[
                                      indexIngredientByDay]
                                          .ingredientCategories![
                                      indexIngredientCategories]
                                          .ingredients![indexIngredients]
                                          .ingredient!
                                          .imageUrl! ==
                                          "")
                                        Image.asset(
                                          "assets/ingredient/ingredients_default.png",
                                          height: 64,
                                          width: 64,
                                        )
                                      else
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6)),
                                          child: Image.network(
                                            state
                                                .listIngredient[
                                            indexIngredientByDay]
                                                .ingredientCategories![
                                            indexIngredientCategories]
                                                .ingredients![indexIngredients]
                                                .ingredient!
                                                .imageUrl!,
                                            height: 64,
                                            width: 64,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                const EdgeInsets.symmetric(
                                                    vertical: 4),
                                                child: Text(
                                                  state
                                                      .listIngredient[
                                                  indexIngredientByDay]
                                                      .ingredientCategories![
                                                  indexIngredientCategories]
                                                      .ingredients![
                                                  indexIngredients]
                                                      .ingredient!
                                                      .name!,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                const EdgeInsets.symmetric(
                                                    vertical: 4),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "Quantity: ${state
                                                            .listIngredient[indexIngredientByDay]
                                                            .ingredientCategories![indexIngredientCategories]
                                                            .ingredients![indexIngredients]
                                                            .quantity} ${StringUtils
                                                            .parseString(state
                                                            .listIngredient[indexIngredientByDay]
                                                            .ingredientCategories![indexIngredientCategories]
                                                            .ingredients![indexIngredients]
                                                            .measurementType!
                                                            .name!)}",
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              state
                                                  .listIngredient[
                                              indexIngredientByDay]
                                                  .ingredientCategories![
                                              indexIngredientCategories]
                                                  .ingredients![
                                              indexIngredients]
                                                  .note!
                                                  .isNotEmpty
                                                  ? Container(
                                                margin: const EdgeInsets
                                                    .symmetric(
                                                    vertical: 4),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "Note: ${state
                                                            .listIngredient[indexIngredientByDay]
                                                            .ingredientCategories![indexIngredientCategories]
                                                            .ingredients![indexIngredients]
                                                            .note!}",
                                                        style:
                                                        const TextStyle(
                                                            fontSize:
                                                            14),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                                  : Container(),
                                              // buildTrackedComponent(context, state, index),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Checkbox(
                                          shape: const CircleBorder(),
                                          value: state
                                              .listIngredient[
                                          indexIngredientByDay]
                                              .ingredientCategories![
                                          indexIngredientCategories]
                                              .ingredients![indexIngredients]
                                              .checked,
                                          fillColor:
                                          MaterialStateProperty.resolveWith(
                                              getColor),
                                          onChanged: (value) {
                                            BlocProvider.of<GroupsBloc>(context)
                                                .add(GroupUpdateIngredientEvent(
                                                dateStart: state.dateStart,
                                                listIngredient:
                                                state.listIngredient,
                                                value: value!,
                                                dateEnd: state.dateEnd,
                                                ingredient: state
                                                    .listIngredient[
                                                indexIngredientByDay]
                                                    .ingredientCategories![
                                                indexIngredientCategories]
                                                    .ingredients![
                                                indexIngredients],
                                                indexIngredientByDay:
                                                indexIngredientByDay,
                                                indexIngredients:
                                                indexIngredients,
                                                indexIngredientCategories:
                                                indexIngredientCategories));
                                          })
                                    ]),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Text(
                                          "Swipe to update",
                                          style: TextStyle(
                                              color: AppColors.gray,
                                              fontSize: 10),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              }),
            ),
            isExpanded: data[indexIngredientByDay]);
      }),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return AppColors.green;
    }
    return AppColors.orange;
  }

  Widget buildMarketFunction(BuildContext context, DateTime dateTime) {
    return BlocConsumer<MarketerBloc, MarketerState>(
        listener: (context, state) {
          if (state is MarketerWaitingState) {
            EasyLoading.show(
              status: "Loading ...",
              maskType: EasyLoadingMaskType.black,
            );
          } else if (state is MarketerFinishedState) {
            if (EasyLoading.isShow) {
              EasyLoading.dismiss();
            }
          } else if (state is MarketerErrorState) {
            showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      title: Text(state.error),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"))
                      ],
                    ));
          }
        }, buildWhen: (previousState, state) {
      if (state is MarketerWaitingState || state is MarketerFinishedState) {
        return false;
      }
      return true;
    }, builder: (context, state) {
      if (state is MarketerReady) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Marketer: ${state.marketer}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                buildMarketButton(context, state, dateTime),
              ],
            ));
      }

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                "Marketer: N/A",
                style: TextStyle(fontSize: 18),
              )),
        ],
      );
    });
  }

  Widget buildMarketButton(BuildContext context, MarketerReady state,
      DateTime dateTime) {
    if (!state.isReady) {
      return GestureDetector(
        onTap: () {
          String groupId = PreferenceUtils.getString("groupId")!;
          BlocProvider.of<MarketerBloc>(context)
              .add(MarketerAssignEvent(groupId: groupId, date: dateTime));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            "Volunteer",
            style: TextStyle(fontSize: 16, color: AppColors.white),
          ),
        ),
      );
    }
    if (state.isMarketer) {
      return GestureDetector(
        onTap: () {
          String groupId = PreferenceUtils.getString("groupId")!;
          BlocProvider.of<MarketerBloc>(context)
              .add(MarketerUnassignEvent(groupId: groupId, date: dateTime));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.red,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            "Cancel",
            style: TextStyle(fontSize: 16, color: AppColors.white),
          ),
        ),
      );
    }
    return Container();
  }

  Widget buildRangePicker(BuildContext context, IndividualState state) {
    if (state is IndividualNoItem) {
      DateTimeRange dateTimeRange =
      DateTimeRange(start: state.dateStart, end: state.dateEnd);
      String dateStart = DateTimeUtils.parseDateMonth(state.dateStart);
      String dateEnd = DateTimeUtils.parseDateMonth(state.dateEnd);
      return GestureDetector(
          onTap: () async {
            var dateTimeRangeOutput = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
                initialDateRange: dateTimeRange);
            if (dateTimeRangeOutput != null) {
              BlocProvider.of<IndividualBloc>(context).add(
                  IndividualChangeDateEvent(
                      dateStart: dateTimeRangeOutput.start,
                      dateEnd: dateTimeRangeOutput.end));
            }
          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "$dateStart - $dateEnd",
                style: const TextStyle(color: AppColors.white, fontSize: 16),
              )));
    }
    DateTimeRange dateTimeRange = DateTimeRange(
        start: (state as IndividualHasItem).dateStart, end: state.dateEnd);
    String dateStart = DateTimeUtils.parseDateMonth(state.dateStart);
    String dateEnd = DateTimeUtils.parseDateMonth(state.dateEnd);
    return GestureDetector(
        onTap: () async {
          var dateTimeRangeOutput = await showDateRangePicker(
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              initialDateRange: dateTimeRange);
          if (dateTimeRangeOutput != null) {
            BlocProvider.of<IndividualBloc>(context).add(
                IndividualChangeDateEvent(
                    dateStart: dateTimeRangeOutput.start,
                    dateEnd: dateTimeRangeOutput.end));
          }
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "$dateStart - $dateEnd",
              style: const TextStyle(color: AppColors.white, fontSize: 16),
            )));
  }

  Widget buildRangePickerForGroup(BuildContext context, GroupsState state) {
    if (state is GroupNoItem) {
      DateTimeRange dateTimeRange =
      DateTimeRange(start: state.dateStart, end: state.dateEnd);
      String dateStart = DateTimeUtils.parseDateMonth(state.dateStart);
      String dateEnd = DateTimeUtils.parseDateMonth(state.dateEnd);
      return GestureDetector(
          onTap: () async {
            var dateTimeRangeOutput = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
                initialDateRange: dateTimeRange);
            if (dateTimeRangeOutput != null) {
              BlocProvider.of<GroupsBloc>(context).add(GroupChangeDateEvent(
                  dateStart: dateTimeRangeOutput.start,
                  dateEnd: dateTimeRangeOutput.end));
            }
          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "$dateStart - $dateEnd",
                style: const TextStyle(color: AppColors.white, fontSize: 16),
              )));
    }
    DateTimeRange dateTimeRange = DateTimeRange(
        start: (state as GroupHasItem).dateStart, end: state.dateEnd);
    String dateStart = DateTimeUtils.parseDateMonth(state.dateStart);
    String dateEnd = DateTimeUtils.parseDateMonth(state.dateEnd);
    return GestureDetector(
        onTap: () async {
          var dateTimeRangeOutput = await showDateRangePicker(
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              initialDateRange: dateTimeRange);
          if (dateTimeRangeOutput != null) {
            BlocProvider.of<GroupsBloc>(context).add(GroupChangeDateEvent(
                dateStart: dateTimeRangeOutput.start,
                dateEnd: dateTimeRangeOutput.end));
          }
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "$dateStart - $dateEnd",
              style: const TextStyle(color: AppColors.white, fontSize: 16),
            )));
  }
}
