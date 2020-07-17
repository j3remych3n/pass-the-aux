import 'dart:async';
import 'package:aux_ui/aux_lib/qentry.dart';
import 'package:aux_ui/aux_lib/song.dart';
import 'package:aux_ui/aux_lib/spotify_session.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:spotify/spotify.dart';

final String _CLIENT_ID = DotEnv().env['CLIENT_ID'].toString();
final String _REDIRECT_URL = DotEnv().env['REDIRECT_URL'].toString();
final String _CLIENT_SECRET = DotEnv().env['CLIENT_SECRET'].toString();
final String ipAddress = DotEnv().env['IP_ADDRESS'].toString();
final Logger logger = Logger();
SpotifyApi _webApi =
    SpotifyApi(SpotifyApiCredentials(_CLIENT_ID, _CLIENT_SECRET));

class AuxController {
  int sessionId;
  int memberId;

  PhoenixSocket socket;
  PhoenixChannel channel;

  AuxController() {
    socket = new PhoenixSocket("ws://$ipAddress:4000/socket/websocket");
  }

  PhoenixMessageCallback printPayload = (payload, ref, joinRef) {
    logger.d(payload);
  };

  Future<void> connect(sessionId) async {
    this.sessionId = sessionId;
    await socket.connect();

    channel = socket.channel("queue:lobby", {"spotify_uid": "me"});
    var resp = channel.join();

    print('successfully connected: ${resp}');
    this.memberId = 3;
  }

  Future<void> changePos(qentryId, newPrevId) async {
    channel.push(event: "change_pos", payload: {
      "member_id": this.memberId,
      "session_id": this.sessionId,
      "qentry_id": qentryId,
      "new_prev_id": newPrevId
    });
  }

  Future<void> deleteSong(qentryId) async {
    channel.push(event: "delete_song", payload: {"qentry_id": qentryId});
  }

  Future<List<Song>> returnSongs(payload, ref, joinRef) {
    List<Qentry> qentries = payload["songs"]
        .map((item) => Qentry.fromList(item))
        .toList()
        .cast<Qentry>();

    Future<List<Song>> songFutures = Future.wait(
        qentries.map(_songFromQentry).toList().cast<Future<Song>>());
    return songFutures;
  }

  Future<void> getSongs(curry) async {
    channel.on("get_songs", curry(returnSongs));
    _getSongs();
  }

  Future<void> addSong(songId) async {
    channel.push(event: "add_song", payload: {
      "member_id": this.memberId,
      "session_id": this.sessionId,
      "song_id": songId
    });
  }

  Future<void> addSongAndUpdate(songId) async {
    addSong(songId);
    _getSongs();
  }

  Future<void> _getSongs() async {
    channel.push(
        event: "get_songs",
        payload: {"member_id": this.memberId, "session_id": this.sessionId});
  }

  Future<String> getCover(String trackId) async {
    Track track = await _webApi.tracks.get(trackId);
    return track.album.images.last.url;
  }

  // TODO: pipe optional args later
  Future<List<Song>> search(String query,
      {List<SearchType> types = const [SearchType.track],
      int limit = 20,
      String market = 'US',
      bool sorted = true}) async {
    if (query.length == 0) return new List<Song>();

    Set<Song> resultSet = (await _naiveSearch(query)).toSet();
    var pickySearch = await _naiveSearch('"${query}"');
    resultSet.addAll(pickySearch);
    var results = resultSet.toList();
    results.sort((a, b) => b.popularity.compareTo(a.popularity));

    if (results.length > limit) return results.sublist(0, limit);
    return results;
  }

  Future<List<Song>> _naiveSearch(String query,
      {List<SearchType> types = const [SearchType.track],
      int limit = 20,
      String market = 'US',
      bool sorted = true}) async {
    var rawResults = await _webApi.search
        .get(query, types)
        .first(limit)
        .catchError((err) => print((err as SpotifyException).message));

    return rawResults
        .map((page) => page.items
            .where((i) => i is Track)
            .map((track) => _songFromTrack(track)))
        .expand((i) => i)
        .toList();
  }

  Future<Song> _songFromQentry(Qentry qentry) async {
    Song song = _songFromTrack(await _webApi.tracks.get(qentry.trackId));
    song.qentryId = qentry.id;
    return song;
  }

  Song _songFromTrack(Track track) {
    List<String> artists = track.artists.map((a) => a.name).toList();
    String artist = artists.join(', ');
    String cover = track.album.images.last.url;
    return new Song(track.name, artist, cover, track.id,
        popularity: track.popularity);
  }
}
