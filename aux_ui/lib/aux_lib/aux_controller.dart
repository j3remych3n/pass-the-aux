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
final Logger logger = new Logger();
SpotifyApi _webApi =
    new SpotifyApi(new SpotifyApiCredentials(_CLIENT_ID, _CLIENT_SECRET));

PhoenixMessageCallback printPayload = (payload, ref, joinRef) {
  logger.d(payload);
};

PhoenixMessageCallback returnSongs = (payload, ref, joinRef) {};

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

    channel = socket.channel("queue:lobby", {"spotify_user": "me"});

    var resp = channel.join();

    print('successfully connected: ${resp}');

    //TODO: implement following pseudocode for "auth"
    /*
      1. Send spotify user info to backend
      2a.If new user: furnish new memberId (create new entry in member base)
      2b.New or returning user: return memberId
      3. Client sets memberId
    */
    this.memberId = 3;
  }

  Future<void> addSong(songId) async {
    print('received requed to add song: ${songId}');
    channel.push(event: "add_song", payload: {
      "member_id": this.memberId,
      "session_id": this.sessionId,
      "song_id": songId
    });
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

  // BEGIN JS callback mindfuck version
  Future<List<Song>> returnSongs(payload, ref, joinRef) async {
    List<Future<Song>> songFutures =
        payload["songs"].map(Qentry).map(_songFromQentry);
    return Future.wait(songFutures);
  }

  Future<void> getSongs(curry) async {
    // ATTN: would need bijective relationship between event and front-end state object
    channel.on("get_songs", curry(returnSongs));
    channel.push(
        event: "get_songs",
        payload: {"member_id": this.memberId, "session_id": this.sessionId});
  }
  // END JS callback mindfuck

  // BEGIN streamed version
  // List<Song> str_songs = List<Song>();
  // Future<List<Song>> getSongsStream() async {
  //   // in some init function / constructor, but here for illustration
  //   PhoenixMessageCallback callback = (payload, ref, joinRef) async {
  //     List<Qentry> qentries = payload["songs"].map(Qentry);
  //     List<Future<Song>> songFutures = qentries.map(songFromQentry);
  //     str_songs = await Future.wait(songFutures);
  //   };
  //   channel.on("get_songs", callback);

  //   channel.push(
  //       event: "get_songs",
  //       payload: {"member_id": this.memberId, "session_id": this.sessionId});
  //   // create future, based on state of tempy variable
  // }
  // BEGIN streamed version

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

  // Future<Song> getSong(String trackId) async {
  //   return _songFromTrack(await _webApi.tracks.get(trackId));
  // }

  Song _songFromTrack(Track track) {
    List<String> artists = track.artists.map((a) => a.name).toList();
    String artist = artists.join(', ');
    String cover = track.album.images.last.url;
    return new Song(track.name, artist, cover, track.id,
        popularity: track.popularity);
  }
}
