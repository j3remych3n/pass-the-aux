
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/rendering.dart';

class LinkSpotifyButton extends StatefulWidget {
  @override
  _LinkSpotifyState createState() => _LinkSpotifyState();
}

class _LinkSpotifyState extends State<LinkSpotifyButton> {
  @override
  Widget build(BuildContext context) {
    return
      FlatButton(
          onPressed:() {},
          color: auxAccent,
          padding: EdgeInsets.all(18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset('assets/spotify_logo.png', height: 21, width: 21),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'sign up with spotify',
                  strutStyle: StrutStyle(
                      fontSize: 17,
                      height: 1.2
                  ),
                ),
              ),
            ],
          )
      );
  }
}