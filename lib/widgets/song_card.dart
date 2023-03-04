import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import '../models/song.dart';

class SongCard extends StatelessWidget {
  const SongCard({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PaletteGenerator.fromImageProvider(song.getImageProvider()),
      builder: (context, snapshot) => Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: snapshot.connectionState == ConnectionState.done
              ? (snapshot.data as PaletteGenerator).colors.first
              : Colors.white,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: song.getImage(),
              ),
            ),
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 7,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  song.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    color: snapshot.connectionState ==
                                            ConnectionState.done
                                        ? (snapshot.data as PaletteGenerator)
                                            .colors
                                            .last
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  song.artist,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: snapshot.connectionState ==
                                            ConnectionState.done
                                        ? (snapshot.data as PaletteGenerator)
                                            .colors
                                            .last
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
