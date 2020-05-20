import 'package:aux_ui/generic_classes/song.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/material.dart';

class QueueItem extends StatefulWidget {
  final Widget rightPress;
  final Song song;
  final bool showContributor;
  final bool isAccent;

  const QueueItem(
      {Key key,
      this.rightPress,
      this.song,
      this.showContributor = false,
      this.isAccent = false})
      : super(key: key);

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
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(0),
        child: Card(
            elevation: 0,
            color: Colors.transparent,
            child: Container(
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
                      child: Image.asset(widget.song.albumCoverLink,
                          width: imageSize(), height: imageSize()))), //TODO: scale
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 13), // TODO: scale
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.song.name,
                                style: widget.isAccent ? auxHeadline : auxBody2, textAlign: TextAlign.left),
                            Text(bottomText(),
                                style: widget.isAccent ? auxAsterisk : auxBody1, textAlign: TextAlign.left)
                          ]))),
              Align(alignment: Alignment.centerRight, child: widget.rightPress)
            ]))));
  }
}
