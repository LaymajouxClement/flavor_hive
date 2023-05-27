import 'package:flutter/material.dart';

class RecetteScreen extends StatefulWidget {
  @override
  _RecetteScreenState createState() => _RecetteScreenState();
}

class _RecetteScreenState extends State<RecetteScreen> {
  String plat = '';

  void validerPlat() {
    setState(() {
      plat = 'Couscous'; // Remplacez cette ligne par votre logique pour récupérer le plat demandé
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page de renseignement du plat'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  plat = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Plat',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: validerPlat,
              child: Text('Valider'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Plat renseigné : $plat',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
