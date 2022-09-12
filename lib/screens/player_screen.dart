import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/music_player.dart';
import '../widgets/navbar.dart';
import '../widgets/song_slider.dart';
import '../widgets/song_play_toggle_button.dart';
import '../models/song.dart';

class PlayerScreen extends StatefulWidget {
  static const String routeName = '/player';

  const PlayerScreen({Key? key, required this.song, this.alreadyPlaying})
      : super(key: key);

  final Song song;
  final bool? alreadyPlaying;

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    final player = Provider.of<MusicPlayer>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: widget.alreadyPlaying != true
              ? player.playSong(widget.song)
              : null,
          builder: (c, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const NavBar(),
                Image.file(File(widget.song.image!.toFilePath())),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SongSlider(audioPlayer: player.audioPlayer),
                    SongPlayToggleButton(
                      audioPlayer: player.audioPlayer,
                      size: 64,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
