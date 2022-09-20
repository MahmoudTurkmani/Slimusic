import 'package:flutter/material.dart';

import '../widgets/navbar_alt.dart';

class DrawerScreen extends StatelessWidget {
  static const String routeName = '/drawer';
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const Expanded(
              flex: 0,
              child: NavBarAlt(),
            ),
            const Spacer(),
            settingsTile(text: 'Library', icon: Icons.music_note),
            settingsTile(text: 'Queue', icon: Icons.queue),
            settingsTile(text: 'Settings', icon: Icons.settings),
            const Expanded(
              child: Text(
                'Developed by ABS and Pumpkin Person',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Expanded settingsTile({required String text, required IconData icon}) {
  return Expanded(
    flex: 2,
    child: Column(
      children: <Widget>[
        Icon(
          icon,
          size: 64,
        ),
        Text(text),
      ],
    ),
  );
}
