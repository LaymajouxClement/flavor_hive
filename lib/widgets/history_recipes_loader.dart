import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_hive/models/recipes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'item_tile.dart';

class HistoryRecipesLoader extends StatefulWidget {
  const HistoryRecipesLoader({Key? key}) : super(key: key);

  @override
  State<HistoryRecipesLoader> createState() => _HistoryRecipesLoaderState();
}

class _HistoryRecipesLoaderState extends State<HistoryRecipesLoader> {
  late FirebaseFirestore db;

  @override
  void initState() {
    super.initState();
    db = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: db.collection('dishes_generator').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, int index) {
              DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
              List<String> data = documentSnapshot['recipes'].cast<String>();
              return ListTile(
                leading: const Icon(Icons.grass),
                title: Text('${data.join(', ')} (${documentSnapshot['username'].toString()})'),
                subtitle: Text(documentSnapshot['bot_response'].toString()),
                onTap: () {
                },
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                  onPressed: () {
                    db.collection('dishes_generator').doc(documentSnapshot.id).delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
      // fetchData();
  }
}
