import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import '../models/song.dart';

class MusicPlayer extends ChangeNotifier {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.newPlayer();

  Future<void> playSong(Song song) async {
    final String songPath = song.location.toFilePath();
    final MetasImage songImage = MetasImage.file(song.image!.toFilePath());
    const MetasImage songImageAlt = MetasImage.asset('assets/images/cover.png');
    final Metas songMetaData = Metas(
      artist: song.artist,
      title: song.name,
      id: song.id.toString(),
      image: songImage,
      onImageLoadFail: songImageAlt,
    );
    await audioPlayer.open(
      Audio.file(songPath, metas: songMetaData),
      showNotification: true,
    );
  }

  bool get isPlaying {
    return audioPlayer.isPlaying.value;
  }
}
