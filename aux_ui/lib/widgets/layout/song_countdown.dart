import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/material.dart';

class SongCountdown extends StatelessWidget {
  String getNumSongsLeft() {
    // TODO: make this real
    return "3";
  }

  String getNumMinLeft() {
    // TODO: make this real
    return "9";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal*15, // TODO: finalize sizing
        child: Column(children: <Widget>[
          Text("you're on in", style: auxCaption),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
            Column(children: <Widget>[
              Text(getNumSongsLeft(), style: auxAsterisk),
              Text("songs")
            ]),
            Column(children: <Widget>[
              Text(getNumMinLeft(), style: auxAsterisk),
              Text("min.")
            ])
          ])
        ]));
  }
}