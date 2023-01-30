import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './label_text.dart';
import '../../providers/music_library.dart';

class ScanSongsSection extends StatelessWidget {
  const ScanSongsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // The Title
        const LabelText(label: 'Scan Songs'),
        // The button
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => Provider.of<MusicLibrary>(context, listen: false)
                .initProvider(hardRefresh: true)
                .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Scan complete.')))),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              side: MaterialStateProperty.all(
                BorderSide(color: Theme.of(context).primaryColor, width: 2),
              ),
              foregroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
              overlayColor:
                  MaterialStateProperty.all(Colors.green.withOpacity(0.2)),
            ),
            child: const Text(
              'Scan',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    );
  }
}
