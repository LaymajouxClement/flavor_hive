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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Plat',
              ),
            ),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          style: const ButtonStyle(
            backgroundColor:
            MaterialStatePropertyAll<Color>(Colors.black),
          ),
          onPressed: () {
            onPressed();
          },
          child: const Text(
            'Valider',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
