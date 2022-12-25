import 'package:flutter/material.dart';
import 'package:plan_meal_app/config/theme.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/preference_utils.dart';
import 'package:plan_meal_app/domain/string_utils.dart';

class AddShoppingListScreen extends StatefulWidget {
  const AddShoppingListScreen({Key? key}) : super(key: key);

  @override
  State<AddShoppingListScreen> createState() => _AddShoppingListScreenState();
}

class _AddShoppingListScreenState extends State<AddShoppingListScreen> {
  String dateStart = DateTimeUtils.parseDateTime(DateTime.now());
  String dateEnd = DateTimeUtils.parseDateTime(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text("Create shopping list"),),
      bottomSheet: Row(
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

                },
                child: const Text(
                  "Create",
                  style: TextStyle(
                    fontSize: 28,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                      child: TextFormField(
                        onChanged: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field must not be empty";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          labelText: "Name",
                          labelStyle: TextStyle(color: AppColors.green),
                          fillColor: AppColors.greenPastel,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.green),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.green),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100)) ??
                        DateTime.now();
                    dateStart = DateTimeUtils.parseDateTime(date);
                  },
                  onChanged: (value) {
                    dateStart = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This field must not be empty";
                    }
                    return null;
                  },
                  initialValue: dateStart,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: "Start date",
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
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100)) ??
                        DateTime.now();
                    dateEnd = DateTimeUtils.parseDateTime(date);
                  },
                  onChanged: (value) {
                    dateEnd = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This field must not be empty";
                    }
                    return null;
                  },
                  initialValue: dateEnd,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: "End date",
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                      child: TextFormField(
                        onChanged: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field must not be empty";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          labelText: "Note",
                          labelStyle: TextStyle(color: AppColors.green),
                          fillColor: AppColors.greenPastel,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.green),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.green),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
