import 'package:flutter/material.dart';

import '../pages_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static bool _isDarkModeEnabled = false;

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
      home: PagesManager()
    );

    // Update the app's theme
    runApp(app);
  }
}
