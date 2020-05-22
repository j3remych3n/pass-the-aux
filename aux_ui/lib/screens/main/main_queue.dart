import 'dart:typed_data';

import 'package:aux_ui/aux_lib/song.dart';
import 'package:aux_ui/aux_lib/spotify_session.dart';
import 'package:aux_ui/routing/router.dart';
import 'package:aux_ui/widgets/buttons/queue_item_action.dart';
import 'package:aux_ui/widgets/layout/aux_card.dart';
import 'package:aux_ui/widgets/layout/queue_item.dart';
import 'package:aux_ui/widgets/layout/song_countdown.dart';
import 'package:aux_ui/widgets/layout/song_list.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/layout/queue_container.dart';
import 'package:aux_ui/widgets/layout/playback_controls.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/models/track.dart';

class MainQueue extends StatefulWidget {
  final SpotifySession spotifySession;

  const MainQueue({Key key, this.spotifySession}) : super(key: key);

  _MainQueueState createState() => _MainQueueState();
}

class _MainQueueState extends State<MainQueue> {
  List<Song> yourSongs;
  List<Song> queueSongs;
  Widget _currPlaying;
  Widget _expandQueue;
  Widget _songUpNext;
  Widget _header;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initSongList();
  }

  void _initSongList() {
    //TODO: implement fetch here
    setState(() {
      queueSongs = List.filled(
          20,
          Song("Tommy's Party", "Peach Pit", null,
              "Diane"));

      // your songs would be a filter over queue ^ for where contributor == you
      yourSongs = List.filled(
          20,
          Song("Tommy's Party", "Peach Pit", null,
              "Diane"));
    });
  }

  void _initializeWidgets() {
    if (_initialized) return;
    _initialized = true;
    _setSongUpNext();
    _setExpandQueue();
    _setHeader();
  }

  Widget _getCurrPlaying(PlayerState playerState) {
    // TODO possibly pull out into another component

    Track track = playerState.track;
    String name = track.name;
    String artist = track.artist.name;
    ImageUri imageUri = track.imageUri;
    String contributor = "Diane"; // TODO: don't hardcode
    double progress = playerState.playbackPosition / track.duration;

    Widget right = QueueItemAction(onPressed: () {}, icons: [
      Icon(
        Icons.favorite_border,
        color: auxAccent,
        size: 16.0, // TODO: scale
        semanticLabel: "original song",
      ),
      Icon(
        Icons.favorite,
        color: auxAccent,
        size: 16.0, // TODO: scale
        semanticLabel: "liked song",
      )
    ]);

    return FutureBuilder(
      future: spotifySession.getImage(imageUri),
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        if (snapshot.hasData) {
          var albumCover = snapshot.data;
          return AuxCard(
              borderColor: auxBlurple,
              padding: 15.0,
              child: Column(
                children: <Widget>[
                  QueueItem(
                    song: new Song(name, artist, albumCover, contributor),
                    showContributor: true,
                    rightPress: right,
                    isAccent: true,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: auxDDGrey,
                          valueColor: new AlwaysStoppedAnimation<Color>(auxBlurple)))
                ],
              ));
        } else {
          return Center(
            child: Text("Getting image"), // TODO: replace
          );
        }
      }
    );
  }

  void _setExpandQueue() {
    _expandQueue = ButtonTheme(
        height: SizeConfig.blockSizeVertical * 3,
        child: OutlineButton(
            padding: EdgeInsets.only(top: 5, bottom: 5, right: 7, left: 7),
            borderSide: BorderSide(color: auxAccent),
            onPressed: () {},
            color: Colors.transparent,
            child: Row(children: <Widget>[
              Icon(Icons.unfold_more,
                  color: auxAccent, size: 10.0, semanticLabel: "expand queue"),
              Text("view full queue", style: auxCaption)
            ])));
  }

  void _setSongUpNext() {
    Widget right = QueueItemAction(onPressed: () {}, icons: [
      Icon(Icons.more_vert,
          color: auxAccent,
          size: 20.0, // TODO: scale
          semanticLabel: "get next song")
    ]);

    _songUpNext = QueueItem(
      song: queueSongs[0],
      showContributor: true,
      rightPress: right,
    );
  }

  int getNumInParty() {
    // TODO: implement
    return 12;
  }

  String getHost() {
    // TODO: implement
    return "Diane";
  }

  Widget _getHeaderChip(IconData iconName, String text, Color color) {
    return Container(
        padding: EdgeInsets.only(right: 16), // TODO: scale or finalize
        child: Row(
          children: <Widget>[
            Icon(iconName, color: color, size: 10),
            Padding(
                padding: EdgeInsets.only(left: 1),
                child: Text(text, style: auxBody1))
          ],
        ));
  }

  void _setHeader() {
    _header = Column(children: <Widget>[
      Align(
          alignment: Alignment.bottomLeft,
          child: Text('too queue for u', style: auxDisp2)),
      Padding(
          padding: EdgeInsets.only(top: 3), // TODO: scale or finalize
          child: Row(
            children: <Widget>[
              _getHeaderChip(Icons.fiber_manual_record, "LIVE", Colors.red),
              _getHeaderChip(
                  Icons.group, "${getNumInParty()} people in group", auxAccent),
              _getHeaderChip(
                  Icons.person_outline, "hosted by ${getHost()}", auxAccent)
            ],
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _initializeWidgets();
    return StreamBuilder<PlayerState>(
        stream: widget.spotifySession.getPlayerState(),
        initialData: PlayerState(null, true, 1, 1, null, null),
        builder: (BuildContext context, AsyncSnapshot<PlayerState> snapshot) {
          if (snapshot.data != null && snapshot.data.track != null) {
            var playerState = snapshot.data;
            return Material(
                type: MaterialType.transparency,
                child: Container(
                    padding: SizeConfig.notchPadding,
                    color: auxPrimary,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 12, right: 12, top: 42, bottom: 8),
                                  child: _header),
                              _getCurrPlaying(playerState),
                              QueueContainer(
                                  title: 'up next',
                                  child: _songUpNext,
                                  titleWidget: _expandQueue),
                              QueueContainer(
                                title: 'your songs',
                                child:
                                    SongList(songs: yourSongs, onPress: () {}),
                                titleWidget: SongCountdown(),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            bottom: 10,
                            child: PlaybackControls(
                              isHost: true,
                              spotifySession: widget.spotifySession,
                              isPaused: playerState.isPaused,
                            ))
                      ],
                    )));
          } else {
            // TODO: come up with a better alternative to this
            return Center(
              child: Text("Not connected"),
            );
          }
        });
  }
}
