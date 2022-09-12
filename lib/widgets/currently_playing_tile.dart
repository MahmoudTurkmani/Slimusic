import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import '../providers/music_player.dart';
import '../screens/player_screen.dart';
import './song_slider.dart';

class CurrentlyPlayingTile extends StatelessWidget {
  const CurrentlyPlayingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicPlayer>(
      builder: (ctx, player, child) {
        Metas? songMetas = player.getCurrentSongMetas;
        if (!player.isPlaying || songMetas == null) {
          return Container();
        }
        return GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(PlayerScreen.routeName,
              arguments: {
                "song": player.getCurrentSong,
                "alreadyPlaying": true
              }),
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).primaryColor,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(songMetas.image!.path),
                      fit: BoxFit.cover,
                      height: 90,
                    ),
                  ),
                ),
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 7,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      songMetas.title!,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(child: Text(songMetas.artist!)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: IconButton(
                                onPressed: () => player.audioPlayer.previous(),
                                icon: const Icon(Icons.skip_previous_rounded),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: IconButton(
                                onPressed: () =>
                                    player.audioPlayer.playOrPause(),
                                icon: player.audioPlayer.builderIsPlaying(
                                  builder: (context, isPlaying) => Icon(
                                    isPlaying
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: IconButton(
                                onPressed: () => player.audioPlayer.next(),
                                icon: const Icon(Icons.skip_next_rounded),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: SongSlider(audioPlayer: player.audioPlayer)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
