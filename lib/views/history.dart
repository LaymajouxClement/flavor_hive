import 'package:flutter/material.dart';

import '../widgets/history_recipes_loader.dart';

class HistoryPage extends StatefulWidget{
  const HistoryPage({super.key});
  State<HistoryPage> createState () => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage>{
  @override
  Widget build(BuildContext context) {
    final historyRecipesLoader = HistoryRecipesLoader();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
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
        body: TabBarView(
          children: [
            historyRecipesLoader,
            const Text("PLats")
          ],
        ),
      ),
    );
  }
}