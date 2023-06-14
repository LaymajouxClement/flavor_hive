import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

class Recipes {
  Recipes({required this.username, required this.itemsList, required this.botResponse});
  final String username;
  final List<String> itemsList;
  String botResponse = "";

  factory Recipes.fromJson(Map<String, dynamic> data){
    return Recipes(
        username : data["username"],
        itemsList: data["recipes"],
        botResponse : data["bot_response"],
    );
  }

  toJson(){
    return {
      'username' : username,
      'recipes' : itemsList,
      'bot_response' : botResponse,
    };
  }

  void save(Recipes recipes) {
    Map<String, Object> persistedRecipes = {
      'username': recipes.username,
      'recipes': recipes.itemsList,
      'bot_response': recipes.botResponse
    };
    // write into db collection
    db.collection("dishes_generator").add(persistedRecipes);
  }
}
