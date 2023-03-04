import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/music_player.dart';
import '../widgets/navbars/navbar.dart';
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
      backgroundColor: widget.song.primary,
      body: SafeArea(
        child: FutureBuilder(
          future: widget.alreadyPlaying != true
              ? player.playSong(song: widget.song, fromQueue: false)
              : null,
          builder: (c, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                NavBar(
                  displayColor: widget.song.secondary,
                  secondaryColor: widget.song.primary,
                ),
                widget.song.getImage(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SongSlider(
                      audioPlayer: player.audioPlayer,
                      primary: widget.song.primary,
                      secondary: widget.song.secondary,
                    ),
                    SongPlayToggleButton(
                      audioPlayer: player.audioPlayer,
                      size: 64,
                      secondary: widget.song.secondary,
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
