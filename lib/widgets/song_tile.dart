import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import './song_details.dart';
import './song_image.dart';
import '../providers/music_library.dart';
import '../models/song.dart';
import '../screens/player_screen.dart';

class SongTile extends StatelessWidget {
  final Song song;
  const SongTile({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    ///
    /// Options are heled in songOptionsList variable.
    void songOptions() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView(children: songOptionsList);
        },
      );
    }

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
          color: Theme.of(context).primaryColor,
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
                ),
                const Icon(
                  Icons.play_circle_outline_outlined,
                  size: 32,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
