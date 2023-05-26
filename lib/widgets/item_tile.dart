import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({Key? key, required this.message})
      : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Text("> $message"),
        ),
      ],
    );
  }
}
