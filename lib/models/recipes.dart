import 'package:cloud_firestore/cloud_firestore.dart';

class Recipes {
  const Recipes({required this.username, required this.itemsList});
  final String username;
  final List<String> itemsList;

  factory Recipes.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> documentSnapshot){
    final data = documentSnapshot.data()!;
    return Recipes(
        username : data["username"],
        itemsList: data["recipes"],
    );
  }
}
