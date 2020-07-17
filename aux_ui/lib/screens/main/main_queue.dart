import 'package:aux_ui/aux_lib/aux_controller.dart';
import 'package:aux_ui/aux_lib/song.dart';
import 'package:aux_ui/aux_lib/spotify_session.dart';
import 'package:aux_ui/widgets/layout/main_container.dart';
import 'package:aux_ui/widgets/queue_main_display/current_song.dart';
import 'package:aux_ui/widgets/queue_main_display/playback_controls.dart';
import 'package:aux_ui/widgets/queue_main_display/queue_header.dart';
import 'package:aux_ui/widgets/queue_main_display/song_countdown.dart';
import 'package:aux_ui/widgets/layout/song_list.dart';
import 'package:aux_ui/widgets/queue_main_display/song_up_next.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/layout/queue_container.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:aux_ui/routing/routing_constants.dart';
import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

class MainQueue extends StatefulWidget {
  final SpotifySession spotifySession;
  final AuxController controller;

  const MainQueue({Key key, this.spotifySession, this.controller})
      : super(key: key);

  _MainQueueState createState() => _MainQueueState();
}

class _ExpandQueueButton extends StatelessWidget {
  const _ExpandQueueButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        height: SizeConfig.blockSizeVertical * 3,
        child: OutlineButton(
            padding: EdgeInsets.only(top: 0, bottom: 0, right: 7, left: 7),
            borderSide: BorderSide(color: auxAccent),
            onPressed: () {},
            color: Colors.transparent,
            child: Row(children: <Widget>[
              Icon(Icons.unfold_more,
                  color: auxAccent, size: 10.0, semanticLabel: "expand queue"),
              Text("view full queue", style: auxCaption)
            ])));
  }
}

class _MainQueueState extends State<MainQueue> {
  List<Song> yourSongs;
  List<Song> queueSongs;

  @override
  void initState() {
    super.initState();
    _initSongList();
  }

  void _initSongList() {
    this.yourSongs = new List<Song>();
    widget.controller.getSongs(_getSongsCurry);

    setState(() {
      queueSongs = List.filled(
          20,
          Song(
              "Tommy's Party",
              "Peach Pit",
              "https://images.genius.com/22927a8e14101437686b56ce1103e624.1000x1000x1.jpg",
              "spotify:track:5OuJTtNve7FxUX82eEBupN",
              contributor: "Diane"));
    });
  }

  PhoenixMessageCallback _getSongsCurry(callback) {
    return (payload, ref, joinRef) {
      callback(payload, ref, joinRef).then((songs) =>
          this.setState(() => this.yourSongs = new List.from(songs)));
    };
  }

  void _reorderQueue(Song selectedSong, int newPos) {
    int qentryId = selectedSong.qentryId;
    int newPrevId = newPos == 0 ? null : this.yourSongs[newPos - 1].qentryId;
    widget.controller.changePos(qentryId, newPrevId);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StreamBuilder<PlayerState>(
        stream: widget.spotifySession.getPlayerState(),
        initialData: PlayerState(null, true, 1, 1, null, null),
        builder: (BuildContext context, AsyncSnapshot<PlayerState> snapshot) {
          if (snapshot.data != null && snapshot.data.track != null) {
            var playerState = snapshot.data;
            return MainContainer(
                title: "too queue for u",
                header: QueueHeader(),
                body: <Widget>[
                  CurrentSong(
                      playerState: playerState, controller: widget.controller),
                  QueueContainer(
                      height: SizeConfig.blockSizeVertical * 15,
                      title: 'up next',
                      child: SongUpNext(song: queueSongs[0]),
                      titleWidget: IconButton(
                        iconSize: 18,
                        constraints: BoxConstraints.loose(Size(18, 18)),
                        padding: EdgeInsets.only(
                            top: 0, bottom: 0, left: 5, right: 50),
                        icon: Icon(Icons.unfold_more),
                        color: Colors.white,
                        onPressed: () {},
                      )), //const _ExpandQueueButton()),
                  Expanded(
                      child: QueueContainer(
                          title: 'your songs',
                          child: SongList.reorder(
                              onReorder: _reorderQueue,
                              songs: yourSongs,
                              caboose: SizeConfig.blockSizeVertical * 12),
                          titleWidget: SongCountdown()))
                ],
                footerHeight: SizeConfig.blockSizeVertical * 15,
                footer: PlaybackControls(
                  isHost: true,
                  spotifySession: widget.spotifySession,
                  isPaused: playerState.isPaused,
                  addSongAction: () => Navigator.pushNamed(
                      context, MainSearchRoute,
                      arguments: 'placeholder'),
                ));
          } else {
            // TODO: come up with a better alternative to this
            return Center(
              child: Text("Not connected"),
            );
          }
        });
  }
}
