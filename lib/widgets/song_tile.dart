import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:palette_generator/palette_generator.dart';

import './song_details.dart';
import './song_image.dart';
import '../providers/music_library.dart';
import '../models/song.dart';
import '../screens/player_screen.dart';
import 'song_tile_loading.dart';

class SongTile extends StatelessWidget {
  final Song song;
  const SongTile({Key? key, required this.song}) : super(key: key);

  /// Returns the location of a image that the user chooses from his gallery.
  Future<Uri?> _pickImage() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path).uri;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Holds all the options that the user can do to a song.
    final List<ListTile> songOptionsList = <ListTile>[
      ListTile(
        title: const Text('Change cover image'),
        onTap: () {
          _pickImage().then(
            (newCoverUri) {
              if (newCoverUri != null) {
                Provider.of<MusicLibrary>(context, listen: false)
                    .updateCoverImage(
                  newImage: newCoverUri,
                  imageID: song.id,
                );
              }
              Navigator.of(context).pop();
            },
          );
        },
      ),
    ];

    /// Displays the options list.
    /// Options are held in songOptionsList variable.
    void songOptions() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView(children: songOptionsList);
        },
      );
    }

    // Note: The reason the FutureBuilder is here is because
    // The future may have not yet yielded a result by the time this widget
    // is called. Therefore this is a fallback.

    // The actual widget begins here
    return FutureBuilder(
        future: PaletteGenerator.fromImageProvider(
            FileImage(File.fromUri(song.image!))),
        builder: (context, snapshot) {
          // While it is still loading, show the loading tile
          if (snapshot.connectionState != ConnectionState.done) {
            return const SongTileLoading();
          }
          // Once it's done, load the actual tile
          PaletteGenerator paletteData = snapshot.data as PaletteGenerator;
          return GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(PlayerScreen.routeName, arguments: {"song": song}),
            onLongPress: songOptions,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(15),
                color: paletteData.colors.first,
              ),
              height: 200,
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // The cover image of the song
                  SongImage(image: song.image),
                  // The details and name of the song
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Name and artist of the song
                      SongDetails(
                        name: song.name,
                        artist: song.artist,
                        paletteColor: paletteData.colors.last,
                      ),
                      Icon(
                        Icons.play_circle_outline_outlined,
                        size: 32,
                        color: paletteData.colors.last,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
