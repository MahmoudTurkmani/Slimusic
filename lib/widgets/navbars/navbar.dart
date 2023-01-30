import 'package:flutter/material.dart';

import '../../screens/drawer_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key, this.displayColor, this.secondaryColor})
      : super(key: key);

  final Color? displayColor;
  final Color? secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'SliMusic',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: displayColor,
                  fontFamily: 'ABeeZee',
                  fontWeight: FontWeight.bold,
                ),
          ),
          // Button
          InkWell(
            onTap: () async {
              Navigator.of(context).pushNamed(DrawerScreen.routeName);
            },
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.transparent),
                borderRadius: BorderRadius.circular(15),
                color: displayColor ?? Theme.of(context).primaryColor,
              ),
              child: Icon(
                Icons.menu,
                color: secondaryColor ?? Colors.white,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
