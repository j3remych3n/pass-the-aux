import 'package:aux_ui/aux_lib/song.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/material.dart';

class QueueItem extends StatefulWidget {
  Widget rightPress;
  Function onPressed;
  final Song song;
  final bool showContributor;
  final bool isAccent;
  final bool multiSelect;

  QueueItem(
    {
      Key key,
      this.rightPress,
      this.onPressed,
      this.song,
      this.showContributor = false,
      this.isAccent = false,
      this.multiSelect = true,
    }
  ): super(key: key);

  QueueItem.tap(
    {
      Key key,
      @required this.onPressed,
      this.song,
      this.showContributor = false,
      this.isAccent = false,
      this.multiSelect = true,
    }
  ): super(key: key);

  QueueItem.select(
    {
      Key key,
      @required this.rightPress,
      this.song,
      this.showContributor = false,
      this.isAccent = false,
      this.multiSelect = false,
    }
  ): super(key: key);

  _QueueItemState createState() => _QueueItemState();
}

class _QueueItemState extends State<QueueItem> {
  String bottomText() {
    if (widget.showContributor) {
      return widget.song.artist + " | added by " + widget.song.contributor;
    } else {
      return widget.song.artist;
    }
  }

  double imageSize() {
    return widget.isAccent ? 57 : 47;
  }

  @override
  Widget build(BuildContext context) {
    // rebuildAllChildren(context);
    return FlatButton(
      onPressed: widget.onPressed,
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 0.5,
        bottom: SizeConfig.blockSizeVertical * 0.5,
        left: SizeConfig.blockSizeHorizontal * 1,
        right: SizeConfig.blockSizeHorizontal * 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
        side: BorderSide(style: BorderStyle.solid)
      ),
      color: Colors.transparent,
      splashColor: auxDGrey,
      child: Row(children: <Widget>[
        Container(
            foregroundDecoration: BoxDecoration(
                border: Border.all(
                  color: auxAccent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(3)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.network(widget.song.coverLink,
                    width: imageSize(), height: imageSize()))), //TODO: scale
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 13), // TODO: scale
            child: Align(
              alignment: Alignment.centerLeft, 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.song.name,
                    style: widget.isAccent ? auxHeadline : auxBody2,
                    textAlign: TextAlign.left
                  ),
                  Text(
                    bottomText(),
                    style: widget.isAccent ? auxAsterisk : auxBody1,
                    textAlign: TextAlign.left
                  ),
                ]
              )
            )
          )
        ),
        Align(alignment: Alignment.centerRight, child: widget.rightPress)
        ]
      )
    );
  }
}
