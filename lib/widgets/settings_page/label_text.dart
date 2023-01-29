import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  const LabelText({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}
