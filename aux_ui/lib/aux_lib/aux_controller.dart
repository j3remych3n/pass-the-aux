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

/*
TODO: presence list of all the members
 two lists to track queue people (people with and without songs in queue)
 add song => update host to update two lists (update who has songs)
 return song object on callback, empty one still needed
 change header to use returned song object
 debug stream state issue
 null spotify return issue
 figure out controlling for adding/leaving members
 lazy loading?
 */

class AuxController {
  int sessionId;
  int memberId;
  Set<int> memberIds;
  Set<int> memsInQueue;
  Set<int> memsEmptyQueue;
  int currDex;
  bool isHost;

  PhoenixSocket socket;
  PhoenixChannel channel;

  AuxController() {
    memberIds = Set.from([1, 2]);
    memsInQueue = Set.from([1, 2]);
    memsEmptyQueue = new Set();
    currDex = 0;
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
    this.memberId = 1;
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

  Future<Song> nextSong(payload, ref, joinRef) {
    logger.d("NEXT SONG HAS BEEN CALLED");
    if (payload["qentry_id"] == -1) { // TODO: make this check more robust
      logger.d("empty next song for member ${payload["member_id"]}");
      int emptyMem = payload["member_id"];
      // this member is out of songs, move to empty songs
      memsInQueue.remove(emptyMem);
      memsEmptyQueue.add(emptyMem);

      return new Future<Song>.value(new Song(null, null, null, null));
    } else {
      int qentryId = payload["qentry_id"];
      String trackId = payload["song_id"];

      Qentry curr = Qentry(qentryId, trackId);
      logger.d("TRACK QUEUED IS: $trackId");
      Future<Song> song = _songFromQentry(curr);
      return song;
    }
  }

  Future<void> next(curry) async {
    if (memsInQueue.isEmpty) { // return empty song if no more members in queue
      curry(new Future<Song>.value(new Song(null, null, null, null)));
    } else {
      int currMember = memberIds.elementAt(currDex);
      currDex = (currDex + 1) % memsInQueue.length;

      logger.d("currMember is $currMember");
      logger.d("currDex is now $currDex");
      logger.d("members in queue: $memsInQueue");

      channel.on("next", curry(nextSong));
      channel.push(
          event: "next",
          payload: {"member_id": currMember, "session_id": this.sessionId});
      _getSongs(); // TODO: wrong => should notify member who added song to get songs
    }
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
    // TODO: notify host song has been added somehow
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

  Future<void> _getSongs([currMemberId]) async {
    if (currMemberId == null) currMemberId = this.memberId;
    channel.push(
        event: "get_songs",
        payload: {"member_id": currMemberId, "session_id": this.sessionId});
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
