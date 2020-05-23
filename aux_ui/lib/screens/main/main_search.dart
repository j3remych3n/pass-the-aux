import 'package:aux_ui/aux_lib/song.dart';
import 'package:aux_ui/widgets/text_input/aux_text_field.dart';
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
  List<Song> searchResults;

  @override
  void initState() {
    super.initState();
    _initSongList();
  }

  void _initSongList() { //TODO: implement fetch here
    setState(() {
      searchResults = List.filled(20,
          Song(
              "Tommy's Party",
              "Peach Pit",
              "assets/album_cover_example.jpg",
              "Diane"
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
        type: MaterialType.transparency,
        child: Container(
          constraints: BoxConstraints.loose(
            Size.fromHeight(
              SizeConfig.safeAreaVertical
            )
          ),
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
                          child: Text('add a song', style: auxDisp2))),
                  AuxTextField(label: 'search for a song', icon: Icon(Icons.search)),
                  QueueContainer(
                    title: 'your songs',
                    child: SongList(
                        songs: searchResults,
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