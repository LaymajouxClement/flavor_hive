import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../widgets/item_input_home_1.dart';
import '../widgets/item_tile.dart';
import '../widgets/sub_header.dart';
import 'package:http/http.dart' as http;

import '../components/open_ai_helper.dart';
import '../models/openai_model.dart';

class ChatBotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Bot',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _messageController;
  late List<String> _chatHistory;
  late String _chatbotReply;
  late bool _isWaiting;

  final String _apiUrl = 'https://api.openai.com/v1/completions';
  final String _apiKey = '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';

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _chatHistory = [];
    _chatbotReply = '';
    _isWaiting = false;
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final String message = _messageController.text;
    _messageController.clear();

    setState(() {
      _chatHistory.add('User: $message');
      _isWaiting = true;
    });

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'prompt': 'You are a helpful assistant for cooking. User: $message',
        'max_tokens': 50,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final chatbotReply = responseData['choices'][0]['text'];

      setState(() {
        _chatbotReply = chatbotReply;
        _chatHistory.add('Chatbot: $_chatbotReply');
        _isWaiting = false;
      });
    } else {
      setState(() {
        _chatbotReply = 'Error: Failed to communicate with the chatbot.';
        _chatHistory.add(_chatbotReply);
        _isWaiting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuisine Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chatHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_chatHistory[index]),
                );
              },
            ),
          ),
          if (_isWaiting) Text('Waiting for the chatbot...'),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
          if (_chatbotReply.isNotEmpty) Text('Chatbot: $_chatbotReply'),
        ],
      ),
    );
  }
}