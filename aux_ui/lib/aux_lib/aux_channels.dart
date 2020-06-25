import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class AuxChannels {
  final ipAddress = DotEnv().env['IP_ADDRESS'].toString();
  PhoenixSocket socket;
  PhoenixChannel channel;

  AuxChannels() {
    socket = new PhoenixSocket("ws://$ipAddress:4000/socket/websocket");
    channel = socket.channel("queue:lobby", {"id": "myId"});
  }

  Future<void> connect() async {
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