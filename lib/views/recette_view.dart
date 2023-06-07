import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_hive/models/dishes.dart';
import 'package:flavor_hive/widgets/item_input_home_2.dart';
import 'package:flutter/material.dart';

import '../components/open_ai_helper.dart';
import '../models/openai_model.dart';

final db = FirebaseFirestore.instance;

class RecetteScreen extends StatefulWidget {
  const RecetteScreen({super.key});

  @override
  State<RecetteScreen> createState() => _RecetteScreenState();
}

class _RecetteScreenState extends State<RecetteScreen> {
  final TextEditingController _controller1 = TextEditingController();
  String plat = "";
  String dish = "";

  validerPlat(String username, String dish, String choice) {
    setState(() {
      Map<String, String> dishes = {
        'username': username,
        'dish' : dish,
        'process' : choice
      };
      // Save dish to firestore
      db.collection("recipes_generator").add(dishes);
      plat = choice;
    });
  }

  @override
  void initState() {
    super.initState();
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
              onPressed: () async {
                Map<String, String> headers = {
                  'Content-Type': 'application/json;charset=UTF-8',
                  'Charset': 'utf-8',
                  'Authorization': 'Bearer $apiKey'
                };

                String promptData = "Je veux faire ${_controller1.text} en 3 lignes";

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
                  var response =
                      await http.post(url, headers: headers, body: data);
                  if (response.statusCode == 200) {
                    final gptData = gptDataFromJson(toUtf8(response));
                    setState(() {
                      dish = _controller1.text;
                      validerPlat("User4", _controller1.text, gptData.choices[0].text);
                    });
                  }
                }
              }
            ),
            const SizedBox(height: 16.0),
            Text(
              plat,
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
