import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/local/measurement_list.dart';
import 'package:plan_meal_app/data/model/measurement_model.dart';

import 'bloc/update_ingredient_bloc.dart';

const List<String> type = <String>["individual", "group"];

class UpdateIngredient extends StatefulWidget {
  const UpdateIngredient({Key? key}) : super(key: key);

  @override
  State<UpdateIngredient> createState() => _UpdateIngredientState();
}

class _UpdateIngredientState extends State<UpdateIngredient> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<UpdateIngredientBloc, UpdateIngredientState>(
          listener: (context, state) async {
            if (state is UpdateIngredientWaiting) {
              EasyLoading.show(
                status: "Loading ...",
                maskType: EasyLoadingMaskType.black,
              );
            } else if (state is UpdateIngredientFinished) {
              if (EasyLoading.isShow) {
                await EasyLoading.dismiss();
              }
              Navigator.of(context).pop();
            }
          },
          buildWhen: (previousState, state) {
            if (state is UpdateIngredientWaiting || state is UpdateIngredientFinished) {
              return false;
            }
            return true;
          },
          builder: (context, state) {
            if (state is UpdateIngredientInitial) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.ingredientDetailEntity.name,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            BlocProvider.of<UpdateIngredientBloc>(context).add(
                                UpdateIngredientUpdateDataEvent(
                                    ingredientDetailEntity:
                                        state.ingredientDetailEntity,
                                    quantity: int.parse(value),
                                    measurementList: state.measurement));
                          }
                        },
                        initialValue:
                            state.ingredientDetailEntity.quantity.toString(),
                        decoration: const InputDecoration(
                          filled: true,
                          labelText: "Quantity",
                          labelStyle: TextStyle(color: AppColors.green),
                          fillColor: AppColors.greenPastel,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.green),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.green),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: DropdownButtonFormField<MeasurementModel>(
                        value: state.ingredientDetailEntity.measurementType,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          filled: true,
                          fillColor: AppColors.greenPastel,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.green),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.green),
                          ),
                          labelText: "Unit",
                          labelStyle: TextStyle(color: AppColors.green),
                        ),
                        isExpanded: true,
                        elevation: 16,
                        onChanged: (value) {
                          BlocProvider.of<UpdateIngredientBloc>(context).add(
                              UpdateIngredientUpdateDataEvent(
                                  measurementList: state.measurement,
                                  ingredientDetailEntity:
                                      state.ingredientDetailEntity,
                                  measurement: value));
                        },
                        items: measurementList
                            .map<DropdownMenuItem<MeasurementModel>>((value) {
                          return DropdownMenuItem<MeasurementModel>(
                            child: Text(value.measurement),
                            value: value,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        bottomSheet: BlocBuilder<UpdateIngredientBloc, UpdateIngredientState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: const BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: TextButton(
                    onPressed: () {
                      if (state is UpdateIngredientInitial) {
                        BlocProvider.of<UpdateIngredientBloc>(context).add(
                            UpdateIngredientSendDataEvent(
                                ingredientId:
                                    state.ingredientDetailEntity.ingredientId,
                              quantity: state.ingredientDetailEntity.quantity,
                              measurement: state.ingredientDetailEntity.measurementType,
                            ));
                      }
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(
                        fontSize: 28,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
