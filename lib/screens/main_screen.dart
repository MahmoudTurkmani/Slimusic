import 'package:flutter/material.dart';

import '../widgets/navbar.dart';
import '../widgets/song_section.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const <Widget>[
            // The top bar
            NavBar(),
            // The songs section
            SongSection(
              title: 'Your Songs',
            ),
          ],
        ),
      ),
    );
  }
}
