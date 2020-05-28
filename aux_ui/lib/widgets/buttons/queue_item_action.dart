import 'package:flutter/material.dart';

class QueueItemAction extends StatefulWidget {
  final Function onSelect;
  final List<Widget> icons;
  bool selected;

  QueueItemAction(
    {
      Key key, 
      this.onSelect, 
      this.icons,
      this.selected = false,
    }
  ) : super(key: key);

  _QueueItemActionState createState() => _QueueItemActionState();
}

class _QueueItemActionState extends State<QueueItemAction> {
  int _iconNum = 0;

  void _onSelect() {
    print('fuck my butthole');
    widget.selected = !widget.selected;
    widget.onSelect();
    setState(() {
      _iconNum = widget.selected ? 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: this._onSelect,
        color: Colors.transparent,
        icon: widget.icons[_iconNum]);
  }
}
