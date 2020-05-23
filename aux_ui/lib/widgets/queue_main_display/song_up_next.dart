import 'package:aux_ui/aux_lib/song.dart';
import 'package:aux_ui/widgets/buttons/queue_item_action.dart';
import 'package:aux_ui/widgets/layout/queue_item.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';

class SongUpNext extends StatelessWidget {
  final Song song;

  const SongUpNext({Key key, this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget right = QueueItemAction(onPressed: () {}, icons: [
      Icon(Icons.more_vert,
          color: auxAccent,
          size: 20.0, // TODO: scale
          semanticLabel: "get next song")
    ]);

    return QueueItem(
      song: song,
      showContributor: true,
      rightPress: right,
    );
  }
}