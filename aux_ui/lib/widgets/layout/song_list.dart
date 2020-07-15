import 'package:aux_ui/aux_lib/song.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/buttons/queue_item_action.dart';
import 'package:aux_ui/widgets/layout/queue_item.dart';
import 'package:flutter/material.dart';

class SongList extends StatefulWidget {
  static const EMPTY_MSG = 'nothing (yet)!';

  final List<Song> songs;
  final String emptyMessage;
  final bool multiSelect;
  final double caboose;

  Function onSelect;
  Function onPressed;

  SongList(
      {Key key,
      this.songs,
      this.onSelect,
      this.onPressed,
      this.caboose: 0,
      this.multiSelect: true,
      this.emptyMessage: EMPTY_MSG})
      : super(key: key);

  SongList.select(
      {Key key,
      this.songs,
      @required this.onSelect,
      this.caboose: 0,
      this.multiSelect: true,
      this.emptyMessage: EMPTY_MSG})
      : super(key: key);

  SongList.tap(
      {Key key,
      this.songs,
      @required this.onPressed,
      this.caboose: 0,
      this.multiSelect: false,
      this.emptyMessage: EMPTY_MSG})
      : super(key: key);

  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    // if (widget.songs == null || widget.songs.length == 0) {
    //   return Expanded(
    //     child: Align(
    //       alignment: Alignment.center,
    //       child: Text(widget.emptyMessage, style: auxAccentButton),
    //     )
    //   );
    // }
    return ListView.separated(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
        shrinkWrap: true,
        itemCount: widget.songs.length + 1,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(thickness: 0, height: 3, color: Colors.transparent),
        itemBuilder: (BuildContext context, int index) {
          if (index >= widget.songs.length)
            return Divider(
                thickness: 0,
                height: widget.caboose,
                color: Colors.transparent);
          if (widget.multiSelect) {
            return QueueItem.select(
              rightPress: QueueItemAction(
                  onSelect: () => widget.onSelect(index),
                  icons: [
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
          } else {
            return QueueItem.tap(
              onPressed: () => widget.onPressed(index),
              song: widget.songs[index],
            );
          }
        });
  }
}
