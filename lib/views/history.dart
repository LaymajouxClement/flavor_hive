import 'package:flutter/material.dart';

import '../widgets/history_dishes_loader.dart';
import '../widgets/history_recipes_loader.dart';

class HistoryPage extends StatefulWidget{
  const HistoryPage({super.key});
  State<HistoryPage> createState () => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage>{
  @override
  Widget build(BuildContext context) {
    const historyRecipesLoader = HistoryRecipesLoader();
    const historyDishesLoader = HistoryDishesLoader();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          shadowColor: Colors.amber[800],
          surfaceTintColor: Colors.amber[800],
          foregroundColor: Colors.amber[800],
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              TabBar(
                tabs: [
                  Tab(
                    text: 'Recettes',
                  ),
                  Tab(
                    text: 'Plats',
                  )
                ],
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            historyRecipesLoader,
            historyDishesLoader
          ],
        ),
      ),
    );
  }
}