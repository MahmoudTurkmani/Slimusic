import 'package:flutter/material.dart';

import './screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SliMusic',
      theme: themeData,
      routes: {
        '/': (ctx) => const MainScreen(),
      },
    );
  }
}

// The theme data of the app
ThemeData themeData = ThemeData(
  primarySwatch: Colors.green,
  textTheme: const TextTheme(
    headline4: TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.w500,
    ),
  ),
);
