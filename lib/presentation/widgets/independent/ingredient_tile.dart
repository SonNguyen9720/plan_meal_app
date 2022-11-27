import 'package:flutter/material.dart';

class IngredientTile extends StatefulWidget {
  const IngredientTile(
      {Key? key, required this.name})
      : super(key: key);
  final String name;

  @override
  State<IngredientTile> createState() => _IngredientTileState();
}

class _IngredientTileState extends State<IngredientTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(child: Text(widget.name)),
        ],
      ),
    );
  }
}
