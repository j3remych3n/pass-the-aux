import 'package:flutter/material.dart';

class QueueItemAction extends StatelessWidget {
  final onPressed;
  final Widget icon;

  const QueueItemAction({Key key, this.onPressed, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed, color: Colors.transparent, icon: icon);
  }
}
