import 'package:aux_ui/widgets/layout/song_list.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/layout/queue_container.dart';

class MainQueue extends StatefulWidget {
  _MainQueueState createState() => _MainQueueState();
}

class _MainQueueState extends State<MainQueue> {
  List<String> songs = [];
  List<String> artists = [];
  List<String> albumCoverLinks = [];

  @override
  void initState() {
    super.initState();
    _initSongList();
  }

  void _initSongList() {
    _getSongs();
    _getArtists();
    _getAlbumCoverLinks();
  }

  void _getSongs() { // TODO: fetch for real
    setState(() {
      songs = List.filled(20, "Tommy's Party");
    });
  }

  void _getArtists() { // TODO: fetch for real
    setState(() {
      artists = List.filled(20, "Peach Pit");
    });
  }

  void _getAlbumCoverLinks() { // TODO: fetch for real
    setState(() {
      albumCoverLinks = List.filled(20, "assets/album_cover_example.jpg");
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      type: MaterialType.transparency,
      child:
        Container(
          padding: SizeConfig.notchPadding,
          color: auxPrimary,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left:12, right:12, top:42, bottom: 8),
                  child: 
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('too queue for u', style: auxDisp2)
                    )
                ),
                QueueContainer(
                  title: 'your songs',
                  child: SongList(
                      songs: songs,
                      artists: artists,
                      albumCoverLinks: albumCoverLinks),
                  titleWidget: Text('title widget'),
                ),
              ],
            ),
        ),
      )
    );
  }
}