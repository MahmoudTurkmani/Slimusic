import 'dart:io';

import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import '../widgets/navbar.dart';
import '../models/song.dart';

class PlayerScreen extends StatefulWidget {
  static const String routeName = '/player';

  const PlayerScreen({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AssetsAudioPlayer _audioPlayer;
  late PlayingAudio currentSong;

  @override
  void initState() {
    super.initState();

    _audioPlayer = AssetsAudioPlayer.newPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _audioPlayer.open(
            Audio.file(widget.song.location.toFilePath()),
            showNotification: true,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            currentSong = _audioPlayer.current.value!.audio;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const NavBar(),
                Image.file(File(widget.song.image!.toFilePath())),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _audioPlayer.builderCurrentPosition(
                      builder: (context, position) {
                        Duration songLength = currentSong.duration;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                '${(position.inSeconds / 60).floor()}:${position.inSeconds % 60}'),
                            Slider(
                              min: 0,
                              max: songLength.inSeconds.toDouble(),
                              value: position.inSeconds.toDouble(),
                              onChanged: (value) async {
                                await _audioPlayer
                                    .seek(Duration(seconds: value.toInt()));
                              },
                            ),
                            Text(
                                '${(songLength.inSeconds / 60).floor()}:${songLength.inSeconds % 60}'),
                          ],
                        );
                      },
                    ),
                    PlayerBuilder.playerState(
                      player: _audioPlayer,
                      builder: (context, state) {
                        return IconButton(
                          iconSize: 64,
                          icon: Icon(
                            state == PlayerState.play
                                ? Icons.pause_circle_outline
                                : Icons.play_circle_outline,
                            size: 64,
                          ),
                          onPressed: () => _audioPlayer.playOrPause(),
                        );
                      },
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
