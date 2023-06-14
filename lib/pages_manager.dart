import 'package:firebase_database/firebase_database.dart';
import 'package:flavor_hive/widgets/BottomNavBarNavigation.dart';
import 'package:flavor_hive/widgets/item_input_home_1.dart';
import 'package:flavor_hive/widgets/item_tile.dart';
import 'package:flutter/material.dart';

import 'widgets/sub_header.dart';

class PagesManager extends StatefulWidget {
  const PagesManager({Key? key}) : super(key: key);

  @override
  State<PagesManager> createState() => _PagesManagerState();
}

class _PagesManagerState extends State<PagesManager> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Le scaffold est la base, la fondation d'une page, chaque page = un scaffold
      // Ce'st lui qui porte le widget tree (DOM)
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("FlavorHive", style: TextStyle(color: Colors.black), textAlign: TextAlign.center,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 20,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        selectedItemColor: Colors.amber[800],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Acceuil',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Menu',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dining),
            label: 'Recette',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.adb),
            label: 'ChatBot',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historique',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.black,
          )
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
      body: Container(
        child: BottomNavBarNavigation(selectedIndex: _selectedIndex), //New
      ),
    );
  }
}
