import 'dart:async';
import 'package:aux_ui/aux_lib/qentry.dart';
import 'package:aux_ui/aux_lib/song.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:spotify/spotify.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final String _CLIENT_ID = DotEnv().env['CLIENT_ID'].toString();
final String _REDIRECT_URL = DotEnv().env['REDIRECT_URL'].toString();
final String _CLIENT_SECRET = DotEnv().env['CLIENT_SECRET'].toString();
final String ipAddress = DotEnv().env['IP_ADDRESS'].toString();
final Logger logger = Logger();
SpotifyApi _webApi =
    SpotifyApi(SpotifyApiCredentials(_CLIENT_ID, _CLIENT_SECRET));

class AuxController {
  // Client webClient = http.Client();
  int _sessionId;
  int _memberId;
  final String _spotifyUid;

  PhoenixSocket socket;
  PhoenixChannel channel;

  //TODO: auth in the future is based on memberId + spotify Username
  AuxController(this._spotifyUid) {
    socket = new PhoenixSocket("ws://$ipAddress:4000/socket/websocket");
  }

  PhoenixMessageCallback printPayload = (payload, ref, joinRef) {
    logger.d(payload);
  };

  Future<void> login() async {
    try {
      var loginResp = await http.post(
          'https://$ipAddress:4000/api/member/create',
          body: {"spotify_uid": this._spotifyUid});
      var body = json.decode(loginResp.body);
      if (body.containsKey('member_id')) this._memberId = body.member_id;
    } finally {}

    await socket.connect();
  }

  Future<void> createSession() async {
    try {
      var createResp = await http.post(
          'https://$ipAddress:4000/api/session/create',
          body: {"spotify_uid": this._spotifyUid, "member_id": this._memberId});
      var body = json.decode(createResp.body);
      if (body.containsKey('session_id')) this._sessionId = body.session_id;
    } finally {}
  }

  Future<void> joinSession(sessionId) async {
    this._sessionId = sessionId;

    channel = socket.channel("queue:lobby",
        {"spotify_uid": this._spotifyUid, "member_id": this._memberId});
    var resp = channel.join();
    print('successfully connected: ${resp}');
  }

  Future<void> changePos(qentryId, newPrevId) async {
    channel.push(event: "change_pos", payload: {
      "member_id": this._memberId,
      "session_id": this._sessionId,
      "qentry_id": qentryId,
      "new_prev_id": newPrevId
    });
  }

  Future<void> deleteSong(qentryId) async {
    channel.push(event: "delete_song", payload: {
      "qentry_id": qentryId,
      "member_id": this._memberId,
      "spotify_uid": this._spotifyUid
    });
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
      "member_id": this._memberId,
      "session_id": this._sessionId,
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
        payload: {"member_id": this._memberId, "session_id": this._sessionId});
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
