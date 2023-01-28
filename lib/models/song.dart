import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class Song {
  int id;
  String name;
  String artist;
  Uri? image;
  Uri location;
  late Color primary;
  late Color secondary;

  Song({
    required this.id,
    required this.location,
    required this.name,
    required this.artist,
    this.image,
  }) {
    // Get the primary and secondary colors from the image
    PaletteGenerator.fromImageProvider(getImageProvider()).then((value) {
      primary = value.colors.first;
      secondary = value.colors.last;
    });
  }

  @override
  String toString() {
    Map<String, String> details = {
      'id': id.toString(),
      'name': name,
      'artist': artist,
      'image': image == null ? 'NA' : image.toString(),
      'location': location.path,
    };
    return jsonEncode(details);
  }

  Image getImage() {
    return image == null
        ? Image.asset('assets/images/cover.png')
        : Image.file(File.fromUri(image!));
  }

  ImageProvider getImageProvider() {
    ImageProvider assetImage = const AssetImage('assets/images/cover.png');
    if (image == null) {
      return assetImage;
    }

    ImageProvider fileImage = FileImage(File.fromUri(image!));
    return fileImage;

    // For some reason, the code below doesn't work. Hence the code above.

    // return image == null
    //     ? AssetImage('assets/images/cover.png')
    //     : FileImage(File.fromUri(image!));
  }
}
