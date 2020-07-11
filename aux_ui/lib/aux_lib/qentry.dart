class Qentry {
  int id;
  String trackId;

  Qentry(List<String> schema) {
    this.id = int.parse(schema[0]);
    this.trackId = schema[1];
  }
}
