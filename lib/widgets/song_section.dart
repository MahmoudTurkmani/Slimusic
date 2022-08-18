import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './song_tile.dart';
import '../providers/music_library.dart';

class SongSection extends StatelessWidget {
  const SongSection({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // The text and arrow above the song list
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: Theme.of(context).textTheme.headline5),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
        // The song list
        SizedBox(
          height: 200,
          child: Consumer<MusicLibrary>(
            builder: (ctx, lib, child) => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: lib.songList.length,
              itemBuilder: ((context, index) =>
                  SongTile(song: lib.songList[index])),
            ),
          ),
        ),
      ],
    );
  }
}
