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

class MainQueue extends StatefulWidget {
  final SpotifySession spotifySession;

  const MainQueue({Key key, this.spotifySession}) : super(key: key);

  _MainQueueState createState() => _MainQueueState();
}

class _ExpandQueueButton extends StatelessWidget {
  const _ExpandQueueButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
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
    //TODO: implement fetch here
    setState(() {
      queueSongs = List.filled(
          20,
          Song("Tommy's Party", "Peach Pit",
              "https://images.genius.com/22927a8e14101437686b56ce1103e624.1000x1000x1.jpg",
              "spotify:track:5OuJTtNve7FxUX82eEBupN",
              contributor: "Diane"));

      // your songs would be a filter over queue ^ for where contributor == you
      yourSongs = List.filled(
          20,
          Song("Tommy's Party", "Peach Pit",
              "https://images.genius.com/22927a8e14101437686b56ce1103e624.1000x1000x1.jpg",
              "spotify:track:5OuJTtNve7FxUX82eEBupN",
              contributor: "Diane"));
    });
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
              CurrentSong(playerState: playerState,
                spotifySession: widget.spotifySession),
              QueueContainer(
                height: 125,
                  title: 'up next',
                  child: SongUpNext(song: queueSongs[0]),
                  titleWidget: const _ExpandQueueButton()),
              Expanded(child: QueueContainer(
                title: 'your songs',
                child:
                SongList(
                    songs: yourSongs, songOnPress: (int x) {}),
                titleWidget: SongCountdown()))
              ],
              footer: PlaybackControls(
                              isHost: true,
                              spotifySession: widget.spotifySession,
                              isPaused: playerState.isPaused,
                            )
            );


//            return Material(
//                type: MaterialType.transparency,
//                child: Container(
//                    constraints: BoxConstraints.loose(
//                        Size.fromHeight(
//                            SizeConfig.safeAreaVertical
//                        )
//                    ),
//                    padding: SizeConfig.notchPadding,
//                    color: auxPrimary,
//                    child: Stack(
//                      children: <Widget>[
//                        Column(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          mainAxisSize: MainAxisSize.min,
//                          children: <Widget>[
//                            Container(
//                                padding: EdgeInsets.only(
//                                    left: 12, right: 12, top: 42, bottom: 8),
//                                child: QueueHeader()),
//                            CurrentSong(playerState: playerState,
//                                spotifySession: widget.spotifySession),
//                            QueueContainer(
//                              height: 125,
//                                title: 'up next',
//                                child: SongUpNext(song: queueSongs[0]),
//                                titleWidget: const _ExpandQueueButton()),
//                            Expanded(child: QueueContainer(
//
//                              title: 'your songs',
//                              child:
//                              SongList(
//                                  songs: yourSongs, songOnPress: (int x) {}),
//                              titleWidget: SongCountdown()),
//                            ),
//                          ],
//                        ),
//                        Positioned(
//                            bottom: 50,
//                            child: PlaybackControls(
//                              isHost: true,
//                              spotifySession: widget.spotifySession,
//                              isPaused: playerState.isPaused,
//                            ))
//                      ],
//                    )));
          } else {
            // TODO: come up with a better alternative to this
            return Center(
              child: Text("Not connected"),
            );
          }
        });
  }
}
