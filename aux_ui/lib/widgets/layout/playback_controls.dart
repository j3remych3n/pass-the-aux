import 'package:flutter/material.dart';

class PlaybackControls extends StatelessWidget {
  Widget _addGuest;
  Widget _playback;
  Widget _addSong;
  Widget _settings;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person_add,
              size: 17,
              semanticLabel: "add guest",
            ),
          )
        ],
      )
    );
  }
  
}