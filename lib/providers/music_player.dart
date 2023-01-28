import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import '../models/song.dart';

class MusicPlayer extends ChangeNotifier {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.newPlayer();
  Song? _currentSong;

  /// Plays a given `Song`
  ///
  /// Takes 3 arguments: The song you wish to play, The primary color, The secondary color
  Future<void> playSong(Song song) async {
    final String songPath = song.location.toFilePath();
    final MetasImage songImage = song.image == null
        ? const MetasImage.asset('assets/images/cover.png')
        : MetasImage.file(song.image!.toFilePath());
    final Metas songMetaData = Metas(
      artist: song.artist,
      title: song.name,
      id: song.id.toString(),
      image: songImage,
    );
    await audioPlayer
        .open(
      Audio.file(songPath, metas: songMetaData),
      showNotification: true,
    )
        .whenComplete(
      () {
        _currentSong = song;
        notifyListeners();
      },
    );

    audioPlayer.playlistAudioFinished.listen((event) {
      notifyListeners();
    });
  }

  bool get isPlaying {
    return audioPlayer.current.hasValue;
  }

  Metas? get getCurrentSongMetas {
    if (!isPlaying) {
      return null;
    } else {
      return audioPlayer.current.value?.audio.audio.metas;
    }
  }

  // Note: should only be called by the currently_playing_tile widget!
  Song? get getCurrentSong {
    if (!isPlaying) {
      return null;
    }
    return _currentSong;
  }
}
