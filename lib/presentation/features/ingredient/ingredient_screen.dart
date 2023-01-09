import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/repositories/abstract/measurement_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/ingredient_detail_entity.dart';
import 'package:plan_meal_app/presentation/features/ingredient/bloc/ingredient_bloc.dart';
import 'package:plan_meal_app/presentation/features/ingredient/modify_ingredient/bloc/modify_ingredient_bloc.dart';
import 'package:plan_meal_app/presentation/features/ingredient/modify_ingredient/modify_ingredient_screen.dart';
import 'package:plan_meal_app/presentation/features/ingredient/search.dart';

class IngredientScreen extends StatefulWidget {
  const IngredientScreen({Key? key, required this.dateTime, required this.type}) : super(key: key);
  final DateTime dateTime;
  final String type;

  @override
  State<IngredientScreen> createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  late DateTime dateTime;

  @override
  void initState() {
    dateTime = widget.dateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IngredientBloc, IngredientState>(
      listener: (context, state) async {
        if (state is IngredientFinished) {
          if (EasyLoading.isShow) {
            await EasyLoading.dismiss();
          }
          Navigator.of(context).pushNamed(PlanMealRoutes.market);
        } else if (state is IngredientLoading) {
          EasyLoading.show(
            status: "It takes few minute, please wait",
            maskType: EasyLoadingMaskType.black,
          );
        }
      },
      buildWhen: (previousState, state) {
        if (state is IngredientLoading) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Add Ingredients"),
            actions: [
              IconButton(
                  onPressed: () async {
                    var ingredientEntity = await showSearch(
                        context: context, delegate: SearchIngredient(type: widget.type));
                    if (state is IngredientInitial) {
                      if (ingredientEntity != null) {
                        BlocProvider.of<IngredientBloc>(context).add(
                            IngredientAddIngredientEvent(
                                ingredientDetailEntityList:
                                    state.listIngredientDetailEntity,
                                ingredientDetailEntity: ingredientEntity,
                                date: dateTime));
                      }
                    }
                  },
                  icon: const Icon(Icons.search_sharp)),
            ],
          ),
          body: buildBody(context, state),
          bottomSheet: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: const BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: TextButton(
              onPressed: () {
                if (state is IngredientInitial) {
                  BlocProvider.of<IngredientBloc>(context).add(
                      IngredientSendIngredientEvent(
                          date: dateTime,
                          ingredientDetailEntityList:
                              state.listIngredientDetailEntity));
                }
              },
              child: const Text(
                "Done",
                style: TextStyle(fontSize: 24, color: AppColors.white),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildBody(BuildContext context, IngredientState state) {
    if (state is IngredientInitial) {
      return Column(
        children: [
          buildDatePicker(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  children: List.generate(
                state.listIngredientDetailEntity.length,
                (index) => GestureDetector(
                  onTap: () async {
                    showBarModalBottomSheet(
                        context: context,
                        builder: (context) => BlocProvider<ModifyIngredientBloc>(
                              create: (context) => ModifyIngredientBloc(
                                  measurementRepository:
                                      RepositoryProvider.of<MeasurementRepository>(
                                          context))
                                ..add(ModifyIngredientLoadDataEvent(
                                    ingredientDetailEntity:
                                        state.listIngredientDetailEntity[index])),
                              child: ModifyIngredientScreen(
                                ingredientDetailEntity:
                                    state.listIngredientDetailEntity[index],
                              ),
                            )).then((value) => BlocProvider.of<IngredientBloc>(context).add(
                              IngredientUpdateIngredientEvent(
                                  ingredientDetailEntity:
                                      value as IngredientDetailEntity,
                                  ingredientDetailEntityList:
                                      state.listIngredientDetailEntity,
                                  date: dateTime,
                                  index: index)));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.listIngredientDetailEntity[index].name,
                                    style: const TextStyle(fontSize: 20, height: 1.2),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${state.listIngredientDetailEntity[index].quantity} ${state.listIngredientDetailEntity[index].measurementType.measurement}",
                                        style: const TextStyle(
                                            color: AppColors.gray, height: 1.2),
                                      ),
                                      Text(
                                        " - for ${state.listIngredientDetailEntity[index].type}",
                                        style: const TextStyle(
                                          color: AppColors.gray,
                                          height: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${state.listIngredientDetailEntity[index].calories * state.listIngredientDetailEntity[index].quantity} kcal",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<IngredientBloc>(context).add(
                                      IngredientRemoveIngredientEvent(
                                          ingredientDetailEntityList:
                                              state.listIngredientDetailEntity,
                                          ingredientDetailEntity:
                                              state.listIngredientDetailEntity[index],
                                          date: dateTime));
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: AppColors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
            ),
          ),
        ],
      );
    }
    return Container();
  }

  Widget buildDatePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: dateTime,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            if (newDate != null) {
              setState(() {
                dateTime = newDate;
              });
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              DateTimeUtils.parseDateTime(dateTime),
              style: const TextStyle(color: AppColors.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
