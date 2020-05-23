import 'package:aux_ui/aux_lib/song.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/layout/main_container.dart';

class MainSearch extends StatefulWidget {
  final spotifySession;
  const MainSearch({Key key, this.spotifySession}) : super(key: key);
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
    return MainContainer(title: 'add a song', children:[]);
  }
}