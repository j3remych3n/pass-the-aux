class Song implements Comparable<Song>{
  final String name;
  final String artist;
  final String coverLink;
  final String spotifyUri;
  final int popularity;
  String contributor;

  Song(this.name, this.artist, this.coverLink, this.spotifyUri, 
    {this.contributor, this.popularity = 0});

  void attributeTo(String user) {
    this.contributor = user;
  }
  
  @override
  bool operator==(other) {
    if (! (other is Song)) return false;
    return other.spotifyUri == this.spotifyUri;
  }

  @override
  int get hashCode {
    return this.spotifyUri.hashCode;
  }

  @override
  int compareTo(Song other) {
    return other.popularity.compareTo(this.popularity);
  }
}