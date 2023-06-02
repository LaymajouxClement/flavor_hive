import 'package:firebase_database/firebase_database.dart';
import 'package:flavor_hive/models/dishes.dart';
import 'package:flavor_hive/widgets/item_input_home_2.dart';
import 'package:flutter/material.dart';

class RecetteScreen extends StatefulWidget {
  const RecetteScreen({super.key});

  @override
  State<RecetteScreen> createState() => _RecetteScreenState();
}

class _RecetteScreenState extends State<RecetteScreen> {
  final TextEditingController _controller1 = TextEditingController();
  String plat = "";
  String dish = "";
  late DatabaseReference dbRef;

  validerPlat(String username, String dish) {
    setState(() {
      Map<String, String> _dishes = {
        'username': username,
        'dish' : dish
      };
      print(_dishes);
      // Save dish to flutter
      // dbRef.push().set(_dishes);
      plat = 'En cours de génération de recette pour $dish';
    });
  }

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Dishes');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page de renseignement du plat'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ItemInputHomeTwo(
              controller: _controller1,

              onPressed: () {
                setState(() {
                  dish = _controller1.text;
                  validerPlat("User4", _controller1.text);
                    });
                _controller1.clear();
              }
            ),
            // const SizedBox(height: 16.0),
            // ElevatedButton(
            //   style: const ButtonStyle(
            //     backgroundColor:
            //     MaterialStatePropertyAll<Color>(Colors.black),
            //   ),
            //   onPressed: validerPlat("User3", dish),
            //   child: const Text(
            //       'Valider',
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),
            const SizedBox(height: 16.0),
            Text(
              'Plat renseigné : $plat',
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
