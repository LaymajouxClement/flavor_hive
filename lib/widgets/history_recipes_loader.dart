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
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('Recipes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              final data = document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['username']),
                subtitle: Text(data['recipes']),
              );
            }).toList(),
          );
        },
      ),
    );
      // fetchData();
  }
}
