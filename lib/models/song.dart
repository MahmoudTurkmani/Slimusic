import 'dart:convert';

class Song {
  int id;
  String name;
  Uri? image;
  Uri location;

  Song({
    required this.id,
    required this.location,
    required this.name,
    this.image,
  });

  @override
  String toString() {
    Map<String, String> details = {
      'id': id.toString(),
      'name': name,
      'image': (image ?? 'NA') as String,
      'location': location.path,
    };
    return jsonEncode(details);
  }
}
