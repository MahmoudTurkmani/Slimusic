import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../providers/music_library.dart';
import '../widgets/navbar.dart';
import '../widgets/song_section.dart';
import '../widgets/currently_playing_tile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final permissionDeniedMenu = Consumer<MusicLibrary>(
      builder: (ctx, library, _) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
                'Please give us permission to your storage so that we can list your songs.\nWe promise not to misuse it :)'),
            ElevatedButton(
              onPressed: () async {
                await Permission.storage.request();
                if (await Permission.storage.isGranted) {
                  await library.initProvider();
                  setState(() {});
                }
              },
              child: const Text('Grant permission'),
            ),
          ],
        ),
      ),
    );

    final permissionGrantedMenu = ListView(
      children: const <Widget>[
        // The top bar
        NavBar(),
        // The songs section
        SongSection(
          title: 'Your Songs',
        ),
        Spacer(),
        CurrentlyPlayingTile(),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            return await Provider.of<MusicLibrary>(context, listen: false)
                .initProvider(hardRefresh: true);
          },
          child: FutureBuilder(
            future: Permission.storage.isGranted,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data as bool) {
                  return permissionGrantedMenu;
                } else {
                  return permissionDeniedMenu;
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
