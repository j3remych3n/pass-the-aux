import 'dart:typed_data';

class Song {
  final String name;
  final String artist;
  final Uint8List albumCover;
  final String contributor;

  Song(this.name, this.artist, this.albumCover, this.contributor);
}