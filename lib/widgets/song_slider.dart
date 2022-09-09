import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class SongSlider extends StatelessWidget {
  const SongSlider({Key? key, required this.audioPlayer}) : super(key: key);

  final AssetsAudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return audioPlayer.builderCurrentPosition(
      builder: (context, position) {
        Duration songLength = audioPlayer.current.value!.audio.duration;
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
                await audioPlayer.seek(Duration(seconds: value.toInt()));
              },
            ),
            Text(
                '${(songLength.inSeconds / 60).floor()}:${songLength.inSeconds % 60}'),
          ],
        );
      },
    );
  }
}
