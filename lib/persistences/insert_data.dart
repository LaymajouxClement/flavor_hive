import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeRepository {

  CollectionReference recipes = FirebaseFirestore.instance.collection("recipes");

  Future<void> addRecipe(){ //List<Item> itemList
    return recipes
        .add({
      'username' : "User1",
      'recipes': ["recipe1", "recipe2", "recipe3"], //itemList
    })
        .then((value) => print("Recipe data saved"))
        .catchError((error) => print("Error while saving recipe"));
  }
}