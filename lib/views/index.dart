import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Menu'),
      ),
      body: Column(
        children: [
          Expanded(
            child:
            Center(
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: [
                  Image.asset('01.jpg', fit: BoxFit.cover),
                  Image.asset('02.jpg', fit: BoxFit.cover),
                  Image.asset('03.jpg', fit: BoxFit.cover),
                  Image.asset('04.jpg', fit: BoxFit.cover),
                  Image.asset('05.jpg', fit: BoxFit.cover),

                ],
              ),
          ),

          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Dark Mode'),
            trailing: Switch(
              value: _isDarkModeEnabled,
              onChanged: (value) {
                setState(() {
                  _isDarkModeEnabled = value;
                  _updateTheme(value);
                });
              },
            ),
          ),
          // Add more settings options here
        ],
      ),
    );
  }

  void _updateTheme(bool isDarkMode) {
    ThemeData themeData = isDarkMode ? ThemeData.dark() : ThemeData.light();
    _changeTheme(themeData);
  }

  void _changeTheme(ThemeData themeData) {
    final MaterialApp app = MaterialApp(
      theme: themeData,
      home: const IndexScreen(),
    );

    runApp(app);
  }
}
