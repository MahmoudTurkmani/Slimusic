import 'dart:convert';

class Song {
  int id;
  String name;
  String artist;
  Uri? image;
  Uri location;

  Song({
    required this.id,
    required this.location,
    required this.name,
    required this.artist,
    this.image,
  });

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
}
