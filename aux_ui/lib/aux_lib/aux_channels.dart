import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

class AuxChannels {
  final ipAddress = DotEnv().env['IP_ADDRESS'].toString();
  PhoenixSocket socket;

  AuxChannels() {
    socket = new PhoenixSocket("ws://$ipAddress:4000/socket/websocket");
  }

  Future<void> connectTest() async {
    await socket.connect();
    final channel = socket.channel("queue:lobby", {"id": "myId"});

    channel.on("add_song", (Map payload, String _ref, String _joinRef) {print(payload);});
    channel.join();
    print("==================");
    print("joined");
    print("==================");
    channel.push(event: "add_song", payload: {
      "member_id": 2,
      "session_id": 2,
      "song_id": "spotify:track:2G7V7zsVDxg1yRsu7Ew9RJ"
    });
    print("PUSHED");
  }
}