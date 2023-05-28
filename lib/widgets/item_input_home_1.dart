import 'package:flutter/material.dart';

class ItemInputHomeOne extends StatelessWidget {
  const ItemInputHomeOne(
      {Key? key,
        required this.controller,
        required this.onPressed})
      : super(key: key);
  final TextEditingController controller;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  labelText: "Votre item",
                ))),
        IconButton(
            onPressed: () {
              onPressed();
            },
            icon: const Icon(Icons.add_circle, size: 45))
      ],
    );
  }
}
