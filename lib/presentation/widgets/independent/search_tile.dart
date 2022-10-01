import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_meal_app/config/routes.dart';
import 'package:plan_meal_app/config/theme.dart';

class IngredientTile extends StatefulWidget {
  const IngredientTile(
      {Key? key, required this.ingredientName, required this.isAdded})
      : super(key: key);
  final String ingredientName;
  final bool isAdded;

  @override
  State<IngredientTile> createState() => _IngredientTileState();
}

class _IngredientTileState extends State<IngredientTile> {
  late bool buttonController;

  @override
  void initState() {
    buttonController = widget.isAdded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(PlanMealRoutes.ingredientDetail);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.ingredientName,
                style: GoogleFonts.signika(fontSize: 20),
              ),
            ),
            buttonController
                ? TextButton(
                    onPressed: () {
                      print("On tap button");
                      setState(() {
                        buttonController = !buttonController;
                      });
                    },
                    child:
                        Text("Added", style: GoogleFonts.signika(fontSize: 14)),
                    style: TextButton.styleFrom(
                      primary: AppColors.green,
                      backgroundColor: AppColors.backgroundInput,
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      setState(() {
                        buttonController = !buttonController;
                      });
                    },
                    child:
                        Text("Add", style: GoogleFonts.signika(fontSize: 14)),
                    style: TextButton.styleFrom(
                      primary: AppColors.orange,
                      backgroundColor: AppColors.backgroundInput,
                    ),
                  )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
