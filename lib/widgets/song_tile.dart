import 'package:flutter/material.dart';

import '../models/song.dart';

class SongTile extends StatelessWidget {
  final Song song;
  const SongTile({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // TODO: replace with the cover of the song
          Container(
            height: 140,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor),
          ),
          // The details and name of the song
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Name of the song
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      song.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  // TODO: Replace with artist name
                  Text(
                    'Subtitle',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              // TODO: Turn the button functional/Make it play the song
              const Icon(
                Icons.play_circle_outline_outlined,
                size: 32,
              )
            ],
          )
        ],
      ),
    );
  }
}
