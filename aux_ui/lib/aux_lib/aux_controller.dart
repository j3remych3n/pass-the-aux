import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    this.sessionId = sessionId;

    channel = socket.channel("queue:lobby", {"spotify_user": "me"});
    await socket.connect();
    var resp = channel.join();

    print('successfully connected: ${resp}');

    
    //TODO: implement following pseudocode for "auth"
    /*
      1. Send spotify user info to backend
      2a.If new user: furnish new memberId (create new entry in member base)
      2b.New or returning user: return memberId
      3. Client sets memberId
    */
    this.memberId = 6;
  }

  Future<void> addSong(songId) async {
    print('received requed to add song: ${songId}');
    channel.push(event: "add_song", payload: {
      "member_id": this.memberId,
      "session_id": this.sessionId,
      "song_id": songId
    });
  }
}