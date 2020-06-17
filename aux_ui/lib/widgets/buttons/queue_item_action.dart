import 'package:flutter/material.dart';

class QueueItemAction extends StatefulWidget {
  final Function onSelect;
  final List<Widget> icons;
  int activeIcon;
  bool selected;

  QueueItemAction(
    {
      Key key, 
      this.onSelect, 
      this.icons,
      this.selected = false,
      this.activeIcon = 0,
    }
  ) : super(key: key);

  _QueueItemActionState createState() => _QueueItemActionState();
}

class _QueueItemActionState extends State<QueueItemAction> {

  void _onSelect() {
    print('fuck my butthole');
    widget.selected = !widget.selected;
    widget.onSelect();
    setState(() {
      widget.activeIcon = widget.selected ? 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: this._onSelect,
        color: Colors.transparent,
        icon: widget.icons[widget.activeIcon]);
  }
}
