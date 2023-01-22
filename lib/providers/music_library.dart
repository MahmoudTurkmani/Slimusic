import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:id3/id3.dart';

import '../models/song.dart';

class MusicLibrary extends ChangeNotifier {
  // TODO: Add a way for the user to scan for new songs
  // TODO: Include a way for the user to add directories
  List<String> directories = ['/storage/emulated/0/music/'];
  List<Song> songList = [];

  // Local directories for the app itself
  final String _songDirectories = '/songDirectories';
  final String _songFiles = '/songs';

  /// Returns the directory of a file.
  Future<String> _getFilePath(String directory) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String file = '${dir.path}/SliMusic$directory';
    return file;
  }

  /// Initializes the directories that contain songs.
  ///
  /// These directories are stored in the songDirectories file on the system.
  Future<void> _initDirs() async {
    File file = File(await _getFilePath(_songDirectories));
    if (await file.exists()) {
      String content = await file.readAsString();
      content.split(',').forEach((element) => directories.add(element));
    } else {
      file.create();
    }
  }

  /// Searches all the song files from the directories mentioned in
  /// the directories list.
  ///
  /// These directories are initialized using the _initDirs function.
  void _scanSongs() {
    for (var directory in directories) {
      Directory dir = Directory(directory);
      List<int> songIdList = songList.map((s) => s.id).toList();
      dir.list().forEach((song) {
        if (extension(song.path) == '.mp3') {
          int id = song.hashCode;
          if (!songIdList.contains(id)) {
            String name = basename(song.path);
            String artist = "Unknown";
            Uri location = song.uri;
            // Check if can parse details
            List<int> mp3Bytes = File.fromUri(song.uri).readAsBytesSync();
            MP3Instance mp3instance = MP3Instance(mp3Bytes);
            if (mp3instance.parseTagsSync()) {
              // Casting happens here as all files are mp3
              // Not possible for it to be null
              Map<String, dynamic> tags =
                  mp3instance.getMetaTags() as Map<String, dynamic>;
              name = tags['Title'] ?? name;
              artist = tags['Artist'] ?? artist;
            }
            songList.add(
                Song(id: id, location: location, name: name, artist: artist));
          }
        }
      }).then((value) {
        notifyListeners();
      });
    }
    _storeSongs();
  }

  /// Converts all the songs that are loaded in the app into a string
  /// and stores their details locally so that they can be accessed
  /// quickly on the next load.
  void _storeSongs() async {
    File file = File(await _getFilePath(_songFiles));
    if (await file.exists()) {
      // Remove all the old data
      await file.delete();
    }
    // Create the file again
    await file.create(recursive: true);
    // Store the data
    String content = songList.join('-||-');
    file.writeAsString(content);
  }

  /// Grabs all the songs from the local songs file and loads them in.
  ///
  /// If there aren't any songs there, it scans for songs and adds them.
  Future<void> _initSongs() async {
    bool missingFile = false;
    File file = File(await _getFilePath(_songFiles));
    // Does the file exist?
    if (await file.exists()) {
      String content = await file.readAsString();
      // Is it empty?
      if (content.isNotEmpty) {
        content.split('-||-').forEach((encSong) async {
          Map<String, dynamic> details = jsonDecode(encSong);
          Song loadedSong = Song(
            id: int.parse(details['id']),
            location: Uri.parse(details['location']),
            name: details['name'] as String,
            artist: details['artist'] as String,
            image:
                details['image'] == 'NA' ? null : Uri.parse(details['image']),
          );
          // Check if the user deleted a song from his device
          if (!await File.fromUri(loadedSong.location).exists()) {
            missingFile = true;
          } else {
            songList.add(loadedSong);
          }
        });
      } else {
        _scanSongs();
      }
      // Do all the songs in the file still exist?
      if (missingFile) {
        _scanSongs();
      }
    } else {
      _scanSongs();
    }
    notifyListeners();
  }

  Future<void> initProvider() async {
    // if permission wasn't given, then don't load the rest.
    // This is a fail-safe in case the app runs without permission so that it
    // doesn't waste resources.
    if (await Permission.storage.isDenied) {
      return;
    }
    // Get the directories
    await _initDirs();
    // Get the songs
    await _initSongs();
  }

  void updateCoverImage({required Uri newImage, required int imageID}) {
    Song foundSong = songList.where((song) => song.id == imageID).first;
    foundSong.image = newImage;
    _storeSongs();
    notifyListeners();
  }

  MusicLibrary() {
    initProvider();
  }
}
