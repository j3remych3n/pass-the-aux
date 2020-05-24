class Song {
  final String name;
  final String artist;
  final String coverLink;
  final String spotifyId;
  String contributor;

  Song(this.name, this.artist, this.coverLink, this.spotifyId, {this.contributor});

  void attributeTo(String user) {
    this.contributor = user;
  }
}