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
  final bool reorder;
  final double caboose;

  Function onReorder;
  Function onSelect;
  Function onPressed;

  emptyReorder() {}

  SongList(
      {Key key,
      this.songs,
      this.onSelect,
      this.onPressed,
      this.multiSelect: true,
      this.emptyMessage: EMPTY_MSG,
      this.reorder: false,
      this.onReorder,
      this.caboose: 0})
      : super(key: key);

  SongList.select(
      {Key key,
      this.songs,
      @required this.onSelect,
      this.multiSelect: true,
      this.emptyMessage: EMPTY_MSG,
      this.reorder: false,
        this.caboose: 0})
      : super(key: key);

  SongList.tap(
      {Key key,
      this.songs,
      @required this.onPressed,
      this.multiSelect: false,
      this.emptyMessage: EMPTY_MSG,
      this.reorder: false,
        this.caboose: 0})
      : super(key: key);

  SongList.reorder(
      {Key key,
        this.songs,
        @required this.onReorder,
        this.multiSelect: false,
        this.emptyMessage: EMPTY_MSG,
        this.reorder: true,
        this.caboose: 0})
      : super(key: key);

  _SongListState createState() => _SongListState();
}

class _SongItem extends StatelessWidget {
  final bool multiSelect;
  final int index;
  final Function onSelect;
  final Song song;
  final Function onPressed;

  const _SongItem(
      {Key key,
      this.multiSelect,
      this.index,
      this.onSelect,
      this.song,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (multiSelect) {
      return QueueItem.select(
        rightPress: QueueItemAction(onSelect: () => onSelect(index), icons: [
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
        song: song,
      );
    } else {
      return QueueItem.tap(
        onPressed: () => onPressed(index),
        song: song,
      );
    }
  }
}

class _SongListState extends State<SongList> {
  void _onReorder(int oldDex, int newDex) {
    setState(() {
      if (newDex > oldDex) {
        newDex -= 1;
      }
      final Song song = widget.songs.removeAt(oldDex);
      widget.songs.insert(newDex, song);
      if (widget.onReorder != null) {
        widget.onReorder(song, newDex);
      }
    });
  }

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

    if (widget.reorder) {
      return ReorderableListView(
          onReorder: _onReorder,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
          children: List.generate(widget.songs.length+1, (index) {
            if (index >= widget.songs.length)
              return Divider(
                  key: Key('$index'),
                  thickness: 0,
                  height: widget.caboose,
                  color: Colors.transparent);
            return _SongItem(
                key: Key('$index'),
                multiSelect: widget.multiSelect,
                index: index,
                onSelect: widget.onSelect,
                song: widget.songs[index],
                onPressed: widget.onPressed);
          }));
    } else {
      return ListView.separated(
          padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
          shrinkWrap: true,
          itemCount: widget.songs.length+1,
          separatorBuilder: (BuildContext context, int index) =>
              Divider(thickness: 0, height: 3, color: Colors.transparent),
          itemBuilder: (BuildContext context, int index) {
            if (index >= widget.songs.length)
              return Divider(
                  key: Key('$index'),
                  thickness: 0,
                  height: widget.caboose,
                  color: Colors.transparent);
            return _SongItem(
                key: Key('$index'),
                multiSelect: widget.multiSelect,
                index: index,
                onSelect: widget.onSelect,
                song: widget.songs[index],
                onPressed: widget.onPressed);
          });
    }
  }
}
