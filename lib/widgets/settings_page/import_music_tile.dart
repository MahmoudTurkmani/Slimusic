import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './label_text.dart';
import './scan_songs_section.dart';
import '../../providers/music_library.dart';

class ImportMusicTile extends StatelessWidget {
  const ImportMusicTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(30, 30, 30, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            // Add new directory section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const LabelText(label: 'Add directory'),
                browseButton(context)
              ],
            ),
            // Scan for songs sections
            const ScanSongsSection(),
          ],
        ),
      ),
    );
  }
}

void pickFile(BuildContext c) async {
  String? directory = await FilePicker.platform.getDirectoryPath();
  if (directory != null) {
    if (c.mounted) {
      Provider.of<MusicLibrary>(c, listen: false).addDir(directory).then(
        (value) {
          String message = value
              ? 'Directory added successfully!'
              : 'An error occured while adding the directory.';
          SnackBar sb = SnackBar(content: Text(message));
          ScaffoldMessenger.of(c).showSnackBar(sb);
        },
      );
    }
  }
}

Widget browseButton(BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    child: OutlinedButton.icon(
      onPressed: () => pickFile(ctx),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(Theme.of(ctx).primaryColor),
        side: MaterialStateProperty.all(
            BorderSide(width: 2, color: Theme.of(ctx).primaryColor)),
        shape: MaterialStateProperty.all(const StadiumBorder()),
        overlayColor: MaterialStateProperty.all(Colors.green.withOpacity(0.2)),
      ),
      icon: const Icon(Icons.arrow_drop_down_rounded, size: 32),
      label: const Text(
        'Browse',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
