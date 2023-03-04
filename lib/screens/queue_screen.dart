import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/navbars/navbar.dart';
import '../widgets/song_card.dart';
import '../providers/music_player.dart';
import '../models/song.dart';

class QueueScreen extends StatelessWidget {
  static const String routeName = '/queue';

  const QueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Song> playlist = Provider.of<MusicPlayer>(context).getPlaylist();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const NavBar(),
            if (playlist.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: playlist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(15),
                      child: SongCard(song: playlist[index]),
                    );
                  },
                ),
              ),
            if (playlist.isEmpty) ...[
              const Spacer(),
              const Text(
                'There are no songs in your playlist.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
            ],
          ],
        ),
      ),
    );
  }
}
