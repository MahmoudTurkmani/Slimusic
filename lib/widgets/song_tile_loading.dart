import 'package:flutter/material.dart';

class SongTileLoading extends StatelessWidget {
  const SongTileLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 94, 94, 94),
      ),
      height: 200,
      width: 150,
      // TODO Make the loading tile look a little better
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: <Widget>[
      // The cover image of the song
      // Container(
      //   color: Colors.blueGrey,
      // ),
      // The details and name of the song
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: <Widget>[
      //     // Name and artist of the song
      //     Container(
      //       color: Colors.blueGrey,
      //     ),
      //     Container(
      //       color: Colors.blueGrey,
      //     ),
      //   ],
      // )
      //   ],
      // ),
    );
  }
}
