import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  final String _apiUrl = 'https://api.openai.com/v1/models';
  final String _apiKey = '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';
  final String _model = 'text-davinci-003';

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
        'model': _model,
        'prompt': 'You are a helpful assistant for cooking. User: $message',
        'max_tokens': 50,
        'temperature': 0.7,
        'top_p': 1.0,
        'n': 1,
        'stop': '\n',
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final chatbotReply = responseData['choices'][0]['text'];

      setState(() {
        _chatbotReply = chatbotReply.trim();
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
              reverse: true,
              itemCount: _chatHistory.length,
              itemBuilder: (context, index) {
                final chat = _chatHistory[_chatHistory.length - 1 - index];
                return ListTile(
                  title: Align(
                    alignment: chat.startsWith('User') ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: chat.startsWith('User') ? Colors.grey : Colors.orange,
                      ),
                      child: Text(
                        chat,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isWaiting)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  color: Colors.orange[200],
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}