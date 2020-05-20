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

  @override
  void initState() {
    super.initState();
    _initYourSongList();
  }

  void _initYourSongList() {
    _getYourSongs();
    _getYourArtists();
    _getYourAlbumCoverLinks();
  }

  void _getYourSongs() {
    // TODO: fetch for real
    setState(() {
      yourSongs = List.filled(20, "Tommy's Party");
    });
  }

  void _getYourArtists() {
    // TODO: fetch for real
    setState(() {
      yourArtists = List.filled(20, "Peach Pit");
    });
  }

  void _getYourAlbumCoverLinks() {
    // TODO: fetch for real
    setState(() {
      yourAlbumCoverLinks = List.filled(20, "assets/album_cover_example.jpg");
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
