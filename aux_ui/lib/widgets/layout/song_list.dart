import 'package:aux_ui/aux_lib/song.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/buttons/queue_item_action.dart';
import 'package:aux_ui/widgets/layout/queue_item.dart';
import 'package:flutter/material.dart';

class SongList extends StatefulWidget {
  final List<Song> songs;
  final Function onPress;

  const SongList({Key key, this.songs, this.onPress}) : super(key: key);

  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        height: SizeConfig.safeBlockVertical * 30, // TODO: finalize this
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: widget.songs.length,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(thickness: 0, height: 8, color: Colors.transparent),
            itemBuilder: (BuildContext context, int index) {
              return QueueItem(
                rightPress: QueueItemAction(onPressed: widget.onPress, icons: [
                  Icon(
                    Icons.radio_button_unchecked,
                    color: auxAccent,
                    size: 16.0, // TODO: scale
                    semanticLabel: "aux item action",
                  ),
                  Icon(
                    Icons.radio_button_checked,
                    color: auxAccent,
                    size: 16.0, // TODO: scale
                    semanticLabel: "aux item action",
                  )
                ]),
                song: widget.songs[index],
              );
            }));
  }
}
