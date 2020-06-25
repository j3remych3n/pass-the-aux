class Song implements Comparable<Song>{
  final String name;
  final String artist;
  final String coverLink;
  final String id;
  final int popularity;
  String contributor;

  Song(this.name, this.artist, this.coverLink, this.id, 
    {this.contributor, this.popularity = 0});

  void attributeTo(String user) {
    this.contributor = user;
  }
  
  @override
  bool operator==(other) {
    if (! (other is Song)) return false;
    return other.id == this.id;
  }

  String get uri {
    return "spotify:track:${this.id}";
  }

  @override
  int get hashCode {
    return this.id.hashCode;
  }

  @override
  int compareTo(Song other) {
    return other.popularity.compareTo(this.popularity);
  }
}