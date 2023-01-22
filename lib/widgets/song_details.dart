import 'package:flutter/material.dart';

class SongDetails extends StatelessWidget {
  const SongDetails({
    Key? key,
    required this.name,
    required this.artist,
    required this.paletteColor,
  }) : super(key: key);

  final String name;
  final String artist;
  final Color paletteColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 84),
          child: Text(
            overflow: TextOverflow.ellipsis,
            name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: paletteColor,
                ),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 84),
          child: Text(
            overflow: TextOverflow.ellipsis,
            artist,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: paletteColor,
                ),
          ),
        ),
      ],
    );
  }
}
