import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class AuxController {
  final ipAddress = DotEnv().env['IP_ADDRESS'].toString();
  PhoenixSocket socket;
  PhoenixChannel channel;

  AuxController() {
    socket = new PhoenixSocket("ws://$ipAddress:4000/socket/websocket");
  }

  Future<void> connect() async {
    channel = socket.channel("queue:lobby", {"id": "myId"});
    await socket.connect();
    channel.join();
//    channel.on("add_song", (Map payload, String _ref, String _joinRef) {print(payload);});
  }

  Future<void> addSong(memberId, sessionId, songId) async {
    channel.push(event: "add_song", payload: {
      "member_id": memberId,
      "session_id": sessionId,
      "song_id": songId
    });
  }
}