import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/music_player.dart';
import './screens/main_screen.dart';
import './screens/player_screen.dart';
import './providers/music_library.dart';
import '../models/song.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MusicLibrary>(create: (_) => MusicLibrary()),
        ChangeNotifierProvider<MusicPlayer>(
          create: (_) => MusicPlayer(),
        ),
      ],
      child: MaterialApp(
        title: 'SliMusic',
        theme: themeData,
        routes: {
          '/': (ctx) => const MainScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == PlayerScreen.routeName) {
            return MaterialPageRoute(
              builder: (context) =>
                  PlayerScreen(song: settings.arguments as Song),
            );
          }
        },
      ),
    );
  }
}

// The theme data of the app
ThemeData themeData = ThemeData(
  primaryColor: Colors.green,
  colorScheme:
      const ColorScheme.light(secondary: Color.fromRGBO(121, 173, 220, 1)),
  textTheme: const TextTheme(
    displayMedium: TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      color: Colors.white,
    ),
  ),
);
