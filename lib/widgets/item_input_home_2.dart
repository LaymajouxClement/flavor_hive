import 'package:flutter/material.dart';

class ItemInputHomeTwo extends StatelessWidget {
  const ItemInputHomeTwo(
      {Key? key,
        required this.controller,
        required this.onPressed})
      : super(key: key);
  final TextEditingController controller;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Plat',
              ),
            ),
        ),
      ],
    );
  }
}
