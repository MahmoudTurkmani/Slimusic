import 'dart:async';

import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import '../models/song.dart';

class MusicPlayer extends ChangeNotifier {
  MusicPlayer() {
    _subscriptions.add(audioPlayer.playlistAudioFinished.listen((event) async {
      if (_playlist.length > 1) {
        _playlist.removeAt(0);
        playSong(song: _getSongFromAudio(_playlist[0]), fromQueue: true);
      } else if (_playlist.length == 1) {
        _playlist.clear();
      }
      notifyListeners();
    }));
  }

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.newPlayer();
  Song? _currentSong;
  final List<StreamSubscription> _subscriptions = [];
  final List<Audio> _playlist = [];

  Audio _getAudioFromSong(Song song) {
    final String songPath = song.location.toFilePath();
    final MetasImage songImage = song.image == null
        ? const MetasImage.asset(Song.defaultCoverImage)
        : MetasImage.file(song.image!.toFilePath());
    final Metas songMetaData = Metas(
      artist: song.artist,
      title: song.name,
      id: song.id.toString(),
      image: songImage,
    );

    return Audio.file(songPath, metas: songMetaData);
  }

  Song _getSongFromAudio(Audio audio) {
    Song newSong = Song(
      id: Uri.parse(audio.path).hashCode,
      artist: audio.metas.artist!,
      location: Uri.parse(audio.path),
      name: audio.metas.title!,
      image: audio.metas.image!.path == Song.defaultCoverImage
          ? null
          : Uri.parse(audio.metas.image!.path),
    );

    return newSong;
  }

  /// Plays a given `Song`
  ///
  /// Takes 3 arguments: The song you wish to play, The primary color, The secondary color
  Future<void> playSong({required Song song, required bool fromQueue}) async {
    if (!fromQueue) {
      _playlist.add(_getAudioFromSong(song));
    }

    await audioPlayer
        .open(
      Playlist(audios: _playlist),
      showNotification: true,
      loopMode: LoopMode.none,
    )
        .whenComplete(
      () {
        _currentSong = song;
        notifyListeners();
      },
    );
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

  void addToQueue(Song song) {
    _playlist.isEmpty
        ? playSong(song: song, fromQueue: false)
        : _playlist.add(_getAudioFromSong(song));
  }

  // Note: should only be called by the currently_playing_tile widget!
  Song? get getCurrentSong {
    if (!isPlaying) {
      return null;
    }
    return _currentSong;
  }

  List<Song> getPlaylist() {
    List<Song> newSongList =
        _playlist.map((audio) => _getSongFromAudio(audio)).toList();
    return newSongList;
  }
}
