import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class SongSlider extends StatelessWidget {
  const SongSlider({
    Key? key,
    required this.audioPlayer,
    required this.primary,
    required this.secondary,
  }) : super(key: key);

  final AssetsAudioPlayer audioPlayer;
  final Color primary;
  final Color secondary;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: audioPlayer.builderCurrentPosition(
        builder: (context, position) {
          // If a song is playing, set the duration to its length
          // Otherwise, set it to 0
          Duration songLength = audioPlayer.current.value == null
              ? const Duration(seconds: 0)
              : audioPlayer.current.value!.audio.duration;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${(position.inSeconds / 60).floor()}:${position.inSeconds % 60}',
                style: TextStyle(color: secondary, fontFamily: 'Inter'),
              ),
              Slider(
                min: 0,
                max: songLength.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {
                  await audioPlayer.seek(Duration(seconds: value.toInt()));
                },
              ),
              Text(
                '${(songLength.inSeconds / 60).floor()}:${songLength.inSeconds % 60}',
                style: TextStyle(color: secondary, fontFamily: 'Inter'),
              ),
            ],
          );
        },
      ),
    );
  }
}
