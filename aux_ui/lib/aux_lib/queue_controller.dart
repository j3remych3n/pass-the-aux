import 'package:aux_ui/aux_lib/song.dart';
import 'aux_controller.dart';

class QueueController {
  Map<int, List<Song>> songs;
  AuxController controller;
  List<int> queueOrder;
  int currDex;

  QueueController(songs, controller) {
    this.songs = songs;
    this.controller = controller;
    this.queueOrder = songs.keys;
  }
}
