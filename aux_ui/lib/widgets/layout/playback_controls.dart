import 'package:aux_ui/aux_lib/spotify_session.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/buttons/rounded_action_button.dart';
import 'package:flutter/material.dart';
import 'package:spotify_sdk/models/player_state.dart';

class PlaybackControls extends StatefulWidget {
  final bool isHost;
  final SpotifySession spotifySession;

  const PlaybackControls({Key key, this.isHost, this.spotifySession})
      : super(key: key);

  @override
  _PlaybackControlsState createState() => _PlaybackControlsState();
}

class _PlaybackControlsState extends State<PlaybackControls> {
  void _playPause(bool paused) {
    if (paused) {
      widget.spotifySession.resume();
    } else {
      widget.spotifySession.pause();
    }
  }

  void _skipNext() {
    widget.spotifySession.skipNext();
    widget.spotifySession.resume();
  }

  void _skipPrevious() {
    widget.spotifySession.skipPrevious();
    widget.spotifySession.resume();
  }

  Widget _getStadiumButton(IconData iconName, double iconSize,
      Function onPressed, bool isTransparent, double width, double height) {
    return Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(0),
        child: Center(
            child: FlatButton(
                onPressed: onPressed,
                color: isTransparent ? Colors.transparent : auxAccent,
                splashColor: auxLGrey,
                highlightColor: auxLGrey,
                shape: StadiumBorder(),
                child: Icon(iconName,
                    size: iconSize,
                    color: isTransparent ? auxAccent : auxPrimary))));
  }

  Widget _getRoundButton(IconData iconName, double iconSize, Function onPressed,
      bool isTransparent, int flexVal) {
    return Expanded(
        flex: flexVal,
        child: FlatButton(
            onPressed: onPressed,
            color: isTransparent ? Colors.transparent : auxAccent,
            splashColor: auxLGrey,
            highlightColor: auxLGrey,
            shape: CircleBorder(),
            child: Icon(iconName,
                size: iconSize,
                color: isTransparent ? auxAccent : auxPrimary)));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: scale everything
    return StreamBuilder<PlayerState>(
        stream: widget.spotifySession.getPlayerState(),
        initialData: PlayerState(null, true, 1, 1, null, null),
        builder: (BuildContext context, AsyncSnapshot<PlayerState> snapshot) {
          if (snapshot.data != null && snapshot.data.track != null) {
            var playerState = snapshot.data;
            return Container(
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [auxPrimary, auxPrimary, Colors.transparent],
                  stops: [0, 0.60, 1],
                )),
                child: Row(
                  children: <Widget>[
                    _getRoundButton(Icons.person_add, 17, () {}, false, 3),
                    Expanded(
                        flex: 6,
                        child: Column(
                          children: <Widget>[
                            Align(
                                alignment: widget.isHost
                                    ? Alignment.center
                                    : Alignment.centerLeft,
                                child: RoundedActionButton(
                                    height: 41,
                                    width: SizeConfig.screenWidth * 1 / 2, // TODO: scale
                                    onPressed: () {},
                                    text: "add a song")),
                            Visibility(
                                visible: widget.isHost,
                                child: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Row(
                                      children: <Widget>[
                                        _getRoundButton(Icons.skip_previous, 21, () {_skipPrevious();}, true, 4),
                                        Expanded(
                                            flex: 4,
                                            child: _getStadiumButton(
                                                playerState.isPaused ? Icons.play_arrow : Icons.pause,
                                                27, () {_playPause(playerState.isPaused);}, true, 100, 54)),
                                        _getRoundButton(Icons.skip_next, 21, () {_skipNext();}, true, 4)
                                      ],
                                    )))
                          ],
                        )),
                    Visibility(
                        visible: widget.isHost,
                        child: _getRoundButton(Icons.settings, 17, () {}, false, 3))
                  ],
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
