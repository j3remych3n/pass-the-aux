class Qentry {
  int id;
  String trackId;

  Qentry.fromList(List<dynamic> schema) {
    this.id = schema[0];
    this.trackId = schema[1];
  }

  Qentry(int id, String trackId) {
    this.id = id;
    this.trackId = trackId;
  }
}
