import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class AuxController {
  final ipAddress = DotEnv().env['IP_ADDRESS'].toString();

  PhoenixSocket socket;
  PhoenixChannel channel;
  int sessionId;
  int memberId;

  AuxController() {
    socket = new PhoenixSocket("ws://$ipAddress:4000/socket/websocket");
  }

  Future<void> connect(sessionId) async {
    this.sessionId = 2;//sessionId;

    channel = socket.channel("queue:lobby", {"spotify_user": "me"});
    await socket.connect();
    channel.on("get_songs", _printPayload);
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

  Future<void> changePos(memberId, sessionId, queueId, newPrevId) async {
    channel.push(event: "change_pos", payload: {
      "member_id": memberId,
      "session_id": sessionId,
      "qentry_id": queueId,
      "new_prev_id": newPrevId
    });
  }

  Future<void> deleteSong(queueId) async {
    channel.push(event: "delete_song", payload: {
      "qentry_id": queueId
    });
  }

  Future<void> getSongs(memberId, sessionId) async {
    channel.push(event: "get_songs", payload: {
      "member_id": memberId,
      "session_id": sessionId
    });
  }

  void _printPayload(payload, _ref, _joinRef) {
    Logger l = new Logger();
    l.d("CALLED");
    l.d(payload["songs"]);
  }
}