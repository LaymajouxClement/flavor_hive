import 'package:flutter/material.dart';

import '../pages_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: _isDarkModeEnabled,
              onChanged: (value) {
                setState(() {
                  _isDarkModeEnabled = value;
                  // Call the function to update the theme
                  _updateTheme(value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _updateTheme(bool isDarkMode) {
    ThemeData themeData = isDarkMode ? ThemeData.dark() : ThemeData.light();
    // Call the function to change the theme
    _changeTheme(themeData);
  }

  void _changeTheme(ThemeData themeData) {
    final MaterialApp app = MaterialApp(
      theme: themeData,
      home: const Scaffold(
        body: PagesManager(),
      ),
    );
    runApp(app);
  }
}