import 'package:aux_ui/aux_lib/song.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/layout/main_container.dart';
import 'package:aux_ui/widgets/layout/queue_item.dart';

class MainSearch extends StatefulWidget {
  final spotifySession;
  const MainSearch({Key key, this.spotifySession}) : super(key: key);
  _MainSearchState createState() => _MainSearchState();
}

class _MainSearchState extends State<MainSearch> {
  List<QueueItem> searchResults;

  @override
  void initState() {
    super.initState();
    searchResults = new List();
  }

  void _search(String query) {
    widget.spotifySession.search(query).then(_showResults);
  }

  void _showResults(List<Song> songs) {
    setState(() {
      this.searchResults = songs.map((s) => new QueueItem(song: s));
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MainContainer(title: 'add a song', children:[]);
  }
}
// text field, with onsubmit --> fn((query))