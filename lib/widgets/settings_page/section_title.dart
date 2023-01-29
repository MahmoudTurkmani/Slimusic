import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Color.fromRGBO(4, 15, 15, 1),
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
