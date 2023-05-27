import 'package:flutter/material.dart';
import '../../views/home_view.dart';
import '../../views/recette_view.dart';
import '../../views/ingredients_view.dart';
import '../../views/settings_view.dart';

class BottomNavigationBarItems extends StatelessWidget {
  final int selectedIndex;
  const BottomNavigationBarItems({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return RecetteScreen();
      case 2:
        return const IngredientsScreen();
      case 3:
        return const SettingsScreen();
      default:
        return const HomeScreen();
    }
  }
}
