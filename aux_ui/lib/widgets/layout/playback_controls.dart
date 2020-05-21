import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/buttons/rounded_action_button.dart';
import 'package:flutter/material.dart';

class PlaybackControls extends StatefulWidget {
  final bool isHost;

  const PlaybackControls({Key key, this.isHost}) : super(key: key);

  @override
  _PlaybackControlsState createState() => _PlaybackControlsState();
}

class _PlaybackControlsState extends State<PlaybackControls> {
  bool _pausePressed = false;

  void _playPause() {
    setState(() {
      _pausePressed = !_pausePressed;
    });
    // TODO: implement
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
      bool isTransparent) {
    return
      FlatButton(
          onPressed: onPressed,
          color: isTransparent ? Colors.transparent : auxAccent,
          splashColor: auxLGrey,
          highlightColor: auxLGrey,
          shape: CircleBorder(),
          child: Icon(iconName,
              size: iconSize,
              color: isTransparent ? auxAccent : auxPrimary));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: _getRoundButton(Icons.person_add, 17, () {}, false)),
            Expanded(
                flex: 6,
                child: Column(
                  children: <Widget>[
                    RoundedActionButton(
                        height: 41,
                        width: SizeConfig.screenWidth * 3 / 5, // TODO: scale
                        onPressed: () {},
                        text: "add a song"),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 4, child: _getRoundButton(Icons.skip_previous, 21, () {}, true)),
                        Expanded(flex: 4, child: _getStadiumButton(
                            _pausePressed ? Icons.play_arrow : Icons.pause, 27, () {_playPause();}, true, 100, 54)),
                        Expanded(flex: 4, child: _getRoundButton(Icons.skip_next, 21, () {}, true))
                      ],
                    )
                  ],
                )),
            Expanded(
                flex: 3, child: _getRoundButton(Icons.settings, 17, () {}, false))
          ],
        )
    );
  }
}
