import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/data/local/measurement_list.dart';
import 'package:plan_meal_app/data/model/measurement_model.dart';
import 'package:plan_meal_app/domain/entities/ingredient_detail_entity.dart';
import 'package:plan_meal_app/domain/string_utils.dart';
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
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    locationController.text = widget.ingredientDetailEntity.location;
    noteController.text = widget.ingredientDetailEntity.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ModifyIngredientBloc, ModifyIngredientState>(
          builder: (context, state) {
            if (state is ModifyIngredientInitial) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
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
                                  BlocProvider.of<ModifyIngredientBloc>(context)
                                      .add(ModifyIngredientUpdateDataEvent(
                                          ingredientDetailEntity:
                                              state.ingredientDetailEntity,
                                          quantity: int.parse(value)));
                                }
                              },
                              initialValue: state
                                  .ingredientDetailEntity.quantity
                                  .toString(),
                              decoration: const InputDecoration(
                                filled: true,
                                labelText: "Quantity",
                                labelStyle: TextStyle(color: AppColors.green),
                                fillColor: AppColors.greenPastel,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.green),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.green),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            child: DropdownButtonFormField<MeasurementModel>(
                              value:
                                  state.ingredientDetailEntity.measurementType,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                ),
                                filled: true,
                                fillColor: AppColors.greenPastel,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.green),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.green),
                                ),
                                labelText: "Unit",
                                labelStyle: TextStyle(color: AppColors.green),
                              ),
                              isExpanded: true,
                              elevation: 16,
                              onChanged: (value) {
                                BlocProvider.of<ModifyIngredientBloc>(context)
                                    .add(ModifyIngredientUpdateDataEvent(
                                        ingredientDetailEntity:
                                            state.ingredientDetailEntity,
                                        measurement: value));
                              },
                              items: measurementList
                                  .map<DropdownMenuItem<MeasurementModel>>(
                                      (value) {
                                return DropdownMenuItem<MeasurementModel>(
                                  child: Text(value.measurement),
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
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                ),
                                filled: true,
                                fillColor: AppColors.greenPastel,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.green),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.green),
                                ),
                                labelText: "Type",
                                labelStyle: TextStyle(color: AppColors.green),
                              ),
                              isExpanded: true,
                              elevation: 16,
                              onChanged: (value) {
                                BlocProvider.of<ModifyIngredientBloc>(context)
                                    .add(ModifyIngredientUpdateDataEvent(
                                        ingredientDetailEntity:
                                            state.ingredientDetailEntity,
                                        type: value));
                              },
                              items:
                                  type.map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                  child: Text(
                                      StringUtils.capitalizeFirstChar(value)),
                                  value: value,
                                );
                              }).toList(),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              onChanged: (value) {
                                locationController.text = value;
                              },
                              controller: locationController,
                              decoration: const InputDecoration(
                                filled: true,
                                labelText: "Location",
                                labelStyle: TextStyle(color: AppColors.green),
                                fillColor: AppColors.greenPastel,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.green),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.green),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              onChanged: (value) {
                                noteController.text = value;
                              },
                              initialValue: state.ingredientDetailEntity.note,
                              decoration: const InputDecoration(
                                filled: true,
                                labelText: "Note",
                                labelStyle: TextStyle(color: AppColors.green),
                                fillColor: AppColors.greenPastel,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.green),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.green),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: const BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: TextButton(
                        onPressed: () {
                          var ingredientDetailEntity =
                              state.ingredientDetailEntity.copyWith(
                                  location: locationController.text,
                                  note: noteController.text);
                          Navigator.of(context)
                              .pop(ingredientDetailEntity);
                        },
                        child: const Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.white,
                          ),
                        ),
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
      ),
    );
  }
}
