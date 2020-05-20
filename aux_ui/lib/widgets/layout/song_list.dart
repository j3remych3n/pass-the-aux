import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/buttons/queue_item_action.dart';
import 'package:aux_ui/widgets/layout/queue_item.dart';
import 'package:flutter/material.dart';

class SongList extends StatefulWidget {
  final List<String> songs;
  final List<String> artists;
  final List<String> albumCoverLinks;
  final Function onPress;

  const SongList({Key key, this.songs, this.artists, this.albumCoverLinks, this.onPress}) : super(key: key);

  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.safeBlockVertical*55, // TODO: finalize this
        child: ListView.separated(
        shrinkWrap: true,
        itemCount: widget.songs.length,
            separatorBuilder: (BuildContext context, int index) => Divider(thickness: 0,
            height: 8, color: Colors.transparent),
        itemBuilder: (BuildContext context, int index) {
          return QueueItem(
            rightPress: QueueItemAction(
                onPressed: widget.onPress,
                icon: Icon(
                  Icons.radio_button_unchecked,
                  color: auxAccent,
                  size: 16.0, // TODO: scale
                  semanticLabel: "aux item action",
                )),
            song: widget.songs[index],
            artist: widget.artists[index],
            albumCoverLink: widget.albumCoverLinks[index],
          );
        }));
  }
}
