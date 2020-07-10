import 'package:aux_ui/aux_lib/spotify_session.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/buttons/rounded_action_button.dart';
import 'package:flutter/material.dart';

class PlaybackControls extends StatefulWidget {
  final bool isHost;
  final SpotifySession spotifySession;
  final bool isPaused;
  final Function addSongAction;

  const PlaybackControls(
      {Key key,
      this.isHost,
      this.spotifySession,
      this.isPaused,
      this.addSongAction})
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
    return Row(
      children: <Widget>[
        _getRoundButton(Icons.person_add, 17, () {}, false, 3),
        Expanded(
            flex: 6,
            child: Column(
              children: <Widget>[
                Align(
                    alignment:
                        widget.isHost ? Alignment.center : Alignment.centerLeft,
                    child: RoundedActionButton(
                        height: 41,
                        width: SizeConfig.screenWidth * 1 / 2,
                        // TODO: scale
                        onPressed: widget.addSongAction,
                        text: "add a song")),
                Visibility(
                    visible: widget.isHost,
                    child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Row(
                          children: <Widget>[
                            _getRoundButton(Icons.skip_previous, 21, () {
                              _skipPrevious();
                            }, true, 4),
                            Expanded(
                                flex: 4,
                                child: _getStadiumButton(
                                    widget.isPaused
                                        ? Icons.play_arrow
                                        : Icons.pause,
                                    27, () {
                                  _playPause(widget.isPaused);
                                }, true, 100, 54)),
                            _getRoundButton(Icons.skip_next, 21, () {
                              _skipNext();
                            }, true, 4)
                          ],
                        )))
              ],
            )),
        Visibility(
            visible: widget.isHost,
            child: _getRoundButton(Icons.settings, 17, () {}, false, 3))
      ],
    );
  }
}
