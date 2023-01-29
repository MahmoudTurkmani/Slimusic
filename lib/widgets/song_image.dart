import 'dart:io';

import 'package:flutter/material.dart';

class SongImage extends StatelessWidget {
  const SongImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final Uri? image;

  @override
  Widget build(BuildContext context) {
    // If the song exists, display it
    if (image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.file(
          File.fromUri(image!),
          height: 130,
          width: 150,
          fit: BoxFit.cover,
        ),
      );
    }
    // otherwise, use the default asset
    else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          'assets/images/cover.png',
          height: 140,
          width: 150,
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
