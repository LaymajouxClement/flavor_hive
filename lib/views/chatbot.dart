import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../widgets/open_ai_helper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  Future<String> sendMessage(String message) async {
    String apiUrl = 'https://api.openai.com/v1/chat/completions';
    print(message);
    // Set the request headers
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer ${dotenv.get('OPEN_AI_KEY', fallback: 'OPEN_AI_KEY not found')}'
    };

    // Set the request body
    Map<String, dynamic> requestBody = {
      'prompt': message,
      'max_tokens': 150,
    };
    final data = jsonEncode({
      "model": "text-davinci-003",
      "prompt": message,
      "temperature": 0.4,
      "max_tokens": 110,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0
    });
    print(data);
    // Send the HTTP POST request
    var response = await http.post(Uri.parse(apiUrl), headers: headers, body: data);

    // Check the response status code
    if (response.statusCode == 200) {
      // Parse the response body
      var responseData = jsonDecode(response.body);
      print(responseData);

      // Extract the generated completion text from the response
      String completionText = responseData['choices'][0]['text'];

      return completionText;
    } else {
      // Handle the error case
      throw Exception('Failed to send message: ${response.statusCode}');
    }
  }

  void _sendMessage() {
    if (_textController.text.isNotEmpty) {
      String message = _textController.text;

      setState(() {
        _messages.add({'text': message, 'isUser': true});
        _textController.clear();
      });

      sendMessage(message).then((response) {
        setState(() {
          _messages.add({'text': response, 'isUser': false});
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Chat with our bot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Align(
                    alignment: message['isUser'] ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: message['isUser'] ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        message['text'],
                        style: TextStyle(
                          color: message['isUser'] ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Votre message...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}