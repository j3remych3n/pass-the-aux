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

    channel.on("ping", (Map payload, String _ref, String _joinRef) {print(payload);});
    channel.join();
    channel.push(event: "ping", payload: {'test': 'hi'});
  }
}