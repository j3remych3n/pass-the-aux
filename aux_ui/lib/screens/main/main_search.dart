import 'package:aux_ui/aux_lib/song.dart';
import 'package:aux_ui/widgets/buttons/queue_item_action.dart';
import 'package:aux_ui/widgets/layout/queue_item.dart';
import 'package:aux_ui/widgets/layout/song_countdown.dart';
import 'package:aux_ui/widgets/layout/song_list.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/layout/queue_container.dart';
import 'package:aux_ui/widgets/layout/aux_bottom_shelf.dart';

class MainSearch extends StatefulWidget {
  _MainSearchState createState() => _MainSearchState();
}

class _MainSearchState extends State<MainSearch> {
  List<Song> yourSongs;
  List<Song> queueSongs;

  @override
  void initState() {
    super.initState();
    _initSongList();
  }

  void _initSongList() { //TODO: implement fetch here
    setState(() {
      queueSongs = List.filled(20,
        Song(
          "Tommy's Party",
          "Peach Pit",
          "assets/album_cover_example.jpg",
          "Diane"
        )
      );
      // your songs would be a filter over queue ^ for where contributor == you
      yourSongs = List.filled(20,
          Song(
              "Tommy's Party",
              "Peach Pit",
              "assets/album_cover_example.jpg",
              "Diane"
          )
      );
    });
  }

  Widget getSongUpNext() {
    Widget right = QueueItemAction(
      onPressed: () {},
    );

    return QueueItem(
      song: queueSongs[0],
      showContributor: true,
      rightPress: right,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
        type: MaterialType.transparency,
        child: Container(
          padding: SizeConfig.notchPadding,
          color: auxPrimary,
          child: Stack(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(2.0),
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(
                          left: 12, right: 12, top: 42, bottom: 8),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('too queue for u', style: auxDisp2))),
                  QueueContainer(
                    title: 'up next',
                    child: getSongUpNext(),
                    titleWidget: Text("temp")
                  ),
                  QueueContainer(
                    title: 'your songs',
                    child: SongList(
                        songs: yourSongs,
                      onPress: () {}
                    ),
                    titleWidget: SongCountdown(),
                  ),
                ],
              ),
            ),
          AuxBottomShelf(),
          ]
          )
        ));
  }
}