import 'package:flutter/material.dart';

class NavBarAlt extends StatelessWidget {
  const NavBarAlt({Key? key}) : super(key: key);

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
                  color: Colors.white,
                  fontFamily: 'ABeeZee',
                  fontWeight: FontWeight.bold,
                ),
          ),
          // Button
          InkWell(
            onTap: () async {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.transparent),
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.green,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
