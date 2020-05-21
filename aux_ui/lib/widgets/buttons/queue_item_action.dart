import 'package:flutter/material.dart';

class QueueItemAction extends StatefulWidget {
  final onPressed;
  final List<Widget> icons;

  const QueueItemAction({Key key, this.onPressed, this.icons})
      : super(key: key);

  _QueueItemActionState createState() => _QueueItemActionState();
}

class _QueueItemActionState extends State<QueueItemAction> {
  int _iconNum = 0;

  void _onPressed() {
    if (widget.icons.length > 1) {
      setState(() {
        _iconNum = (_iconNum + 1) % 2;
      });
    }
    widget.onPressed;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: _onPressed,
        color: Colors.transparent,
        icon: widget.icons[_iconNum]);
  }
}