import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/item_input_home_1.dart';
import '../widgets/item_tile.dart';
import '../widgets/sub_header.dart';

final db = FirebaseFirestore.instance;

class HomeScreenFirst extends StatefulWidget {
  const HomeScreenFirst({super.key});

  State<HomeScreenFirst> createState() => _HomeScreenFirstState();
}

class _HomeScreenFirstState extends State<HomeScreenFirst>{
  final TextEditingController _controller1 = TextEditingController();
  final List<String> _items = [];

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
            ItemInputHomeOne(
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
                padding: const EdgeInsets.all(10),
                width: Size.infinite.height,
                decoration: const BoxDecoration(
                ),
                child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(_items[index]),
                        onDismissed: (direction) {
                          setState(() {
                            _items.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${_items[index]} deleted')));
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
                      onPressed: () {
                        Map<String, Object> recipes = {
                          'username': "User2",
                          'recipes' : _items
                        };
                        // write into db collection
                        db.collection("dishes_generator").add(recipes);
                      },
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