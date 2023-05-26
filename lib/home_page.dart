import 'package:firebase_database/firebase_database.dart';
import 'package:flavor_hive/widgets/item_input.dart';
import 'package:flavor_hive/widgets/item_tile.dart';
import 'package:flutter/material.dart';

import 'widgets/sub_header.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller1 = TextEditingController();
  final List<String> _items = [];

  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Recipes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Le scaffold est la base, la fondation d'une page, chaque page = un scaffold
      // Ce'st lui qui porte le widget tree (DOM)
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("FlavorHive", style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    // color: Colors.deepPurple,
                    height: 50.0,
                    child: const SubHeaderTitle(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ItemInput(
                    controller: _controller1,
                    onPressed: () {
                      setState(() {
                        final message = _controller1.text;
                        _items.add(message);
                      });
                      _controller1.clear();
                    }),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: Container(
                    // color: Colors.amber,
                    padding: const EdgeInsets.all(20),
                    width: 300.0,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Color(0xFFDFDFDF)),
                        left: BorderSide(color: Color(0xFFDFDFDF)),
                        right: BorderSide(color: Color(0xFF7F7F7F)),
                        bottom: BorderSide(color: Color(0xFF7F7F7F)),
                      ),
                      // color: Color(0xFFBFBFBF),
                    ),
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: _items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemTile(message: _items[index]);
                        }),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Container(
                    width: 150,
                    color: Colors.black,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.black),
                          ),
                          onPressed: () {
                            Map<String, Object> recipes = {
                              'username': "User2",
                              'recipes' : _items
                            };
                            print(recipes);
                            dbRef.push().set(recipes);
                          },
                          child: const Text('Go'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}