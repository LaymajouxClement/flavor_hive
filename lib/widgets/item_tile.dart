import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({Key? key, required this.message})
      : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.double_arrow),
        trailing: const Icon(
            Icons.compare_arrows,
            color: Colors.red,
            size: 35,
        ),
        title:  Text(
          message,
          style: const TextStyle(fontSize: 25),
        ),
    );
  }
}
