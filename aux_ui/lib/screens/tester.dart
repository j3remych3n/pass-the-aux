import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/layout/aux_card.dart';
import 'package:aux_ui/widgets/layout/queue_item.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/widgets/buttons/queue_item_action.dart';

class Tester extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  SizeConfig().init(context);

    return Container(
        color: auxPrimary,
        child: Padding(
            padding: SizeConfig.notchPadding,
            child: AuxCard(
              borderColor: auxAccent,
              padding: 12.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  QueueItem(
                    rightPress: QueueItemAction(onPressed: () {},
                    icon: Icon(
                      Icons.radio_button_unchecked,
                      color: auxAccent,
                      size: 16.0, // TODO: scale
                      semanticLabel: "aux item action",
                    )),
                    song: "Tommy's Party",
                    artist: "Peach Pit",
                    albumCoverLink: "assets/album_cover_example.jpg",
                    contributor: "Diane",
                    showContributor: false,
                  )
                ],
              ),
            )
        )
    );
  }
}