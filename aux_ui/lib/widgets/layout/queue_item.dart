import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/material.dart';

class QueueItem extends StatefulWidget {
  final Widget rightPress;
  final String song;
  final String artist;
  final String albumCoverLink;
  final String contributor;
  final bool showContributor;

  const QueueItem(
      {Key key,
      this.rightPress,
      this.song,
      this.artist,
      this.albumCoverLink,
      this.contributor,
      this.showContributor})
      : super(key: key);

  _QueueItemState createState() => _QueueItemState();
}

class _QueueItemState extends State<QueueItem> {
  String bottomText() {
    if (widget.showContributor) {
      return widget.artist + " | added by " + widget.contributor;
    } else {
      return widget.artist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
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
                      child: Image.asset(widget.albumCoverLink,
                          width: 47, height: 47))),
              Expanded(child: Padding(
                  padding: EdgeInsets.only(left: 13), // TODO: scale
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.song,
                            style: auxBody2, textAlign: TextAlign.left),
                        Text(bottomText(),
                            style: auxBody1, textAlign: TextAlign.left)
                      ]))),
              Align(alignment: Alignment.centerRight, child: widget.rightPress)
            ]))));
  }
}
