import 'package:flutter/material.dart';
import '../views/history.dart';
import '../views/home_1.dart';
import '../views/recette_view.dart';
import '../views/settings_view.dart';

class BottomNavBarNavigation extends StatelessWidget {
  final int selectedIndex;
  const BottomNavBarNavigation({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        return const HomeScreenFirst();
      case 1:
        return const RecetteScreen();
      case 3:
        return const HistoryPage();
      default:
        return const HomeScreenFirst();
    }
  }
}