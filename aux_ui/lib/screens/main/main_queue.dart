import 'package:aux_ui/widgets/layout/song_countdown.dart';
import 'package:aux_ui/widgets/layout/song_list.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/layout/queue_container.dart';

class MainQueue extends StatefulWidget {
  _MainQueueState createState() => _MainQueueState();
}

class _MainQueueState extends State<MainQueue> {
  List<String> yourSongs = [];
  List<String> yourArtists = [];
  List<String> yourAlbumCoverLinks = [];
  List<String> queueSongs = [];
  List<String> queueArtists = [];
  List<String> queueAlbumCoverLinks = [];

  @override
  void initState() {
    super.initState();
    _initYourSongList();
    _initQueueSongList();
  }

  void _initYourSongList() { // TODO: implement
    setState(() {
      yourSongs = List.filled(20, "Tommy's Party");
      yourArtists = List.filled(20, "Peach Pit");
      yourAlbumCoverLinks = List.filled(20, "assets/album_cover_example.jpg");
    });
  }

  void _initQueueSongList() { //TODO: implement
    setState(() {
      queueSongs = List.filled(20, "Tommy's Party");
      queueArtists = List.filled(20, "Peach Pit");
      queueAlbumCoverLinks = List.filled(20, "assets/album_cover_example.jpg");
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
        type: MaterialType.transparency,
        child: Container(
          padding: SizeConfig.notchPadding,
          color: auxPrimary,
          child: Padding(
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
                  title: 'your songs',
                  child: SongList(
                      songs: yourSongs,
                      artists: yourArtists,
                      albumCoverLinks: yourAlbumCoverLinks),
                  titleWidget: SongCountdown(),
                ),
              ],
            ),
          ),
        ));
  }
}
