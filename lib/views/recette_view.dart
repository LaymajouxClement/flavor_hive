import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flavor_hive/models/dishes.dart';
import 'package:flavor_hive/widgets/item_input_home_2.dart';
import 'package:flutter/material.dart';

import '../widgets/openai_helper.dart';

class RecetteScreen extends StatefulWidget {
  const RecetteScreen({super.key});

  @override
  State<RecetteScreen> createState() => _RecetteScreenState();
}

class _RecetteScreenState extends State<RecetteScreen> {
  final TextEditingController _controller1 = TextEditingController();
  String plat = "";
  String dish = "";

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
                  'Authorization': 'Bearer ${dotenv.get('OPEN_AI_KEY', fallback: 'OPEN_AI_KEY not found')}'
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
                      final Dishes dishes = Dishes(username: "UserTest", dishName:  _controller1.text, process: gptData.choices[0].text);
                      plat = dishes.save(dishes);
                    });
                  }
                }
              }
            ),
            const SizedBox(height: 16.0),
            Expanded(
                child: Text(
                  plat,
                  style: const TextStyle(fontSize: 18.0),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
