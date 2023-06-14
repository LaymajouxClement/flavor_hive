import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

class Dishes {
  Dishes({required this.username, required this.dishName, required this.process});
  final String username;
  final String dishName;
  String process = "";

  String save(Dishes dishes) {
      Map<String, String> persistedDishes = {
        'username': dishes.username,
        'dish' : dishes.dishName,
        'process' : dishes.process
      };
      db.collection("recipes_generator").add(persistedDishes);
      return dishes.process;
  }
}