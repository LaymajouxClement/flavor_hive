import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_hive/models/recipes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryDishesLoader extends StatefulWidget {
  const HistoryDishesLoader({Key? key}) : super(key: key);

  @override
  State<HistoryDishesLoader> createState() => _HistoryDishesLoaderState();
}

class _HistoryDishesLoaderState extends State<HistoryDishesLoader> {
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
        stream: db.collection('recipes_generator').snapshots(),
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
              return ListTile(
                leading: const Icon(Icons.dining_outlined),
                title: Text("${documentSnapshot['dish']} (${documentSnapshot['username']})"),
                subtitle: Text(documentSnapshot['process'].toString()),
                onTap: () {
                },
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                  onPressed: () {
                    db.collection('recipes_generator').doc(documentSnapshot.id).delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
