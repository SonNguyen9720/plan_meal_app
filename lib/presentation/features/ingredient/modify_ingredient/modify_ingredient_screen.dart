import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/domain/entities/ingredient_detail_entity.dart';
import 'package:plan_meal_app/presentation/features/ingredient/modify_ingredient/bloc/modify_ingredient_bloc.dart';

const List<String> type = <String>["individual", "group"];

class ModifyIngredientScreen extends StatefulWidget {
  final IngredientDetailEntity ingredientDetailEntity;

  const ModifyIngredientScreen({Key? key, required this.ingredientDetailEntity})
      : super(key: key);

  @override
  State<ModifyIngredientScreen> createState() => _ModifyIngredientScreenState();
}

class _ModifyIngredientScreenState extends State<ModifyIngredientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ModifyIngredientBloc, ModifyIngredientState>(
        builder: (context, state) {
          if (state is ModifyIngredientInitial) {
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
                  TextFormField(
                    initialValue:
                    state.ingredientDetailEntity.quantity.toString(),
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: "Number of serving",
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
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: DropdownButtonFormField<String>(
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
                        BlocProvider.of<ModifyIngredientBloc>(context).add(
                            ModifyIngredientUpdateDataEvent(
                                measurementList: state.measurement,
                                ingredientDetailEntity:
                                state.ingredientDetailEntity,
                                measurement: value));
                      },
                      items: state.measurement
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: DropdownButtonFormField<String>(
                      value: state.ingredientDetailEntity.type,
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
                        labelText: "Type",
                        labelStyle: TextStyle(color: AppColors.green),
                      ),
                      isExpanded: true,
                      elevation: 16,
                      onChanged: (value) {
                        BlocProvider.of<ModifyIngredientBloc>(context).add(
                            ModifyIngredientUpdateDataEvent(
                                measurementList: state.measurement,
                                ingredientDetailEntity:
                                state.ingredientDetailEntity,
                                type: value));
                      },
                      items: type
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          child: Text(value),
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
      bottomSheet: BlocBuilder<ModifyIngredientBloc, ModifyIngredientState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 24),
                decoration: const BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                child: TextButton(
                  onPressed: () {
                    if (state is ModifyIngredientInitial) {
                      Navigator.of(context).pop(state.ingredientDetailEntity);
                    }
                  },
                  child: const Text("Update", style: TextStyle(
                    fontSize: 28,
                    color: AppColors.white,
                  ),),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}