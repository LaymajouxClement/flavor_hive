import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../widgets/item_input_home_1.dart';
import '../widgets/item_tile.dart';
import '../widgets/sub_header.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final List<String> _items = [];
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Recipes');
  }

  void _addItem(String item) {
    setState(() {
      _items.add(item);
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${_items[index]} deleted')));
  }

  void _submitItems() {
    Map<String, Object> recipes = {
      'username': "User2",
      'recipes': _items
    };
    print(recipes);
    // dbRef.push().set(recipes);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const Expanded(
              child: SizedBox(
                height: 50.0,
                child: SubHeaderTitle(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ItemInputHomeOne(
              controller: _controller1,
              onPressed: () {
                final message = _controller1.text;
                _addItem(message);
                _controller1.clear();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(_items[index]),
                      onDismissed: (direction) {
                        _removeItem(index);
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
                      onPressed: _submitItems,
                      child: const Text('Go'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
