import 'package:flutter/material.dart';

import '../widgets/navbars/navbar_alt.dart';
import '../screens/settings_screen.dart';

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
            settingsTile(
                text: 'Library',
                icon: Icons.music_note_rounded,
                func: () => Navigator.of(context).pushReplacementNamed('/')),
            buttonDivider(context),
            settingsTile(text: 'Queue', icon: Icons.queue_rounded, func: () {}),
            buttonDivider(context),
            settingsTile(
                text: 'Settings',
                icon: Icons.settings,
                func: () =>
                    Navigator.of(context).pushNamed(SettingsScreen.routeName)),
            // SizedBox for a little bit of padding
            const SizedBox(height: 40),
            const Expanded(
              child: Text(
                'Developed by ABS and Pumpkin Person',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Expanded settingsTile({
  required String text,
  required IconData icon,
  required VoidCallback func,
}) {
  return Expanded(
    flex: 2,
    child: GestureDetector(
      onTap: func,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            icon,
            size: 64,
            color: const Color.fromRGBO(44, 58, 58, 1),
          ),
          Text(
            text.toUpperCase(),
            style: const TextStyle(
              fontSize: 24,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              letterSpacing: 3.2,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buttonDivider(BuildContext ctx) {
  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 200),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: const Divider(
        color: Color.fromRGBO(44, 58, 58, 1),
        thickness: 0.5,
      ),
    ),
  );
}
