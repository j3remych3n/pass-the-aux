import 'package:aux_ui/aux_lib/aux_controller.dart';
import 'package:aux_ui/aux_lib/song.dart';
import 'package:aux_ui/aux_lib/spotify_session.dart';
import 'package:aux_ui/widgets/buttons/queue_item_action.dart';
import 'package:aux_ui/widgets/layout/aux_card.dart';
import 'package:aux_ui/widgets/layout/queue_item.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/models/track.dart';

class CurrentSong extends StatelessWidget {
  final PlayerState playerState;
  final AuxController controller;

  const CurrentSong({Key key, this.playerState, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Track track = playerState.track;
    String name = track.name;
    String artist = track.artist.name;
    String trackUri = track.uri.split(':').last;
    String contributor = "Diane"; // TODO: don't hardcode
    double progress = (playerState.playbackPosition == 0 || track.duration == 0)
        ? 0
        : playerState.playbackPosition / track.duration;

    Widget right = QueueItemAction(onSelect: () {}, icons: [
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
        future: controller.getCover(trackUri),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            var albumCover = snapshot.data;
            return AuxCard(
                borderColor: auxBlurple,
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.all(0),
                child: Column(
                  children: <Widget>[
                    QueueItem(
                      song: new Song(name, artist, albumCover, trackUri,
                          contributor: contributor),
                      showContributor: true,
                      rightPress: right,
                      isAccent: true,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: auxDDGrey,
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(auxBlurple)))
                  ],
                ));
          } else {
            return Center(
              child: Text("Getting image"), // TODO: replace
            );
          }
        });
  }
}
