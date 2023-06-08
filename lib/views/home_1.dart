import 'dart:convert';

import 'package:blurry/blurry.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/BottomNavBarNavigation.dart';
import '../components/open_ai_helper.dart';
import '../models/openai_model.dart';
import '../widgets/item_input_home_1.dart';
import '../widgets/item_tile.dart';
import '../widgets/sub_header.dart';

final db = FirebaseFirestore.instance;
bool _isVisible = false;

class HomeScreenFirst extends StatefulWidget {
  const HomeScreenFirst({super.key});

  @override
  State<HomeScreenFirst> createState() => _HomeScreenFirstState();
}

class _HomeScreenFirstState extends State<HomeScreenFirst> {
  final TextEditingController _controller1 = TextEditingController();
  final List<String> _items = [];

  validerIngredients(String user, List<String> ingredients, String choice) {
    Map<String, Object> recipes = {
      'username': "User2",
      'recipes': _items,
      'bot_response': choice
    };
    // write into db collection
      db.collection("dishes_generator").add(recipes);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Expanded(
              child: SizedBox(
                // color: Colors.deepPurple,
                height: 50.0,
                child: SubHeaderTitle(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: ItemInputHomeOne(
                    controller: _controller1,
                    onPressed: () {
                      setState(() {
                        final message = _controller1.text;
                        _items.add(message);
                        _isVisible = true;
                      });
                      _controller1.clear();
                    })),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Container(
                // color: Colors.amber,
                padding: const EdgeInsets.all(10),
                width: Size.infinite.height,
                decoration: const BoxDecoration(),
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(_items[index]),
                      onDismissed: (direction) {
                        setState(() {
                          _items.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('${_items[index]} deleted')));
                      },
                      child: ItemTile(message: _items[index]),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Visibility(
              visible: _isVisible,
              child: Center(
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
                        onPressed: () async {
                          Map<String, String> headers = {
                            'Content-Type': 'application/json;charset=UTF-8',
                            'Charset': 'utf-8',
                            'Authorization': 'Bearer $apiKey'
                          };

                          String promptData =
                              "Donnes moi les noms de 3 propositions de repas à base de ${_items.join(', ')}, ne pas détailler";

                          final data = jsonEncode({
                            "model": "text-davinci-003",
                            "prompt": promptData,
                            "temperature": 0.4,
                            "max_tokens": 110,
                            "top_p": 1,
                            "frequency_penalty": 0,
                            "presence_penalty": 0
                          });

                          if (promptData.isNotEmpty) {
                            var response = await http.post(url,
                                headers: headers, body: data);
                            if (response.statusCode == 200) {
                              final gptData = gptDataFromJson(toUtf8(response));

                              setState(() {
                                validerIngredients(
                                    "User3", _items, gptData.choices[0].text);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Liste des suggestions de menus'),
                                      content: Column(
                                        children: [
                                          for (var item
                                              in gptData.choices.take(3))
                                            Text(item.text),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Fermer'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              });
                            }
                          }
                        },
                        child: const Text('Go'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
