import 'package:flutter/material.dart';

class IngredientTile extends StatefulWidget {
  const IngredientTile(
      {Key? key, required this.name, required this.textEditingController})
      : super(key: key);
  final String name;
  final TextEditingController textEditingController;

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
          TextField(
            controller: widget.textEditingController,
          ),
          const Text("kg"),
        ],
      ),
    );
  }
}
