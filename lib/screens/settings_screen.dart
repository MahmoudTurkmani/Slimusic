import 'package:flutter/material.dart';

import '../widgets/navbar.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: NavBar(),
      ),
    );
  }
}
