import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class SongPlayToggleButton extends StatelessWidget {
  const SongPlayToggleButton({
    Key? key,
    required this.audioPlayer,
    required this.size,
    required this.secondary,
  }) : super(key: key);

  final AssetsAudioPlayer audioPlayer;
  final double size;
  final Color secondary;

  @override
  Widget build(BuildContext context) {
    return PlayerBuilder.playerState(
      player: audioPlayer,
      builder: (context, state) {
        return IconButton(
          iconSize: 64,
          icon: Icon(
            state == PlayerState.play
                ? Icons.pause_circle_outline
                : Icons.play_circle_outline,
            size: size,
            color: secondary,
          ),
          onPressed: () => audioPlayer.playOrPause(),
        );
      },
    );
  }
}
