import 'package:firebase_database/firebase_database.dart';
import 'package:flavor_hive/widgets/item_input.dart';
import 'package:flavor_hive/widgets/item_tile.dart';
import 'package:flutter/material.dart';

import 'widgets/sub_header.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.call,
      size: 150,
    ),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Le scaffold est la base, la fondation d'une page, chaque page = un scaffold
      // Ce'st lui qui porte le widget tree (DOM)
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("FlavorHive", style: TextStyle(color: Colors.black)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 20,
        selectedIconTheme: IconThemeData(color: Colors.deepPurple),
        selectedItemColor: Colors.deepPurple,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Acceuil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.adb),
            label: 'ChatBot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historique',
          )
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
      body: Container(
        child: _pages.elementAt(_selectedIndex), //New
      ),
    );
  }
}
