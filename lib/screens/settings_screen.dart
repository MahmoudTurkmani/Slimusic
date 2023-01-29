import 'package:flutter/material.dart';

import '../widgets/navbar.dart';
import '../widgets/settings_page/section_title.dart';
import '../widgets/settings_page/import_music_tile.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            NavBar(
              displayColor: Color.fromRGBO(4, 15, 15, 1),
            ),
            SectionTitle(title: 'Import Music'),
            ImportMusicTile(),
          ],
        ),
      ),
    );
  }
}
