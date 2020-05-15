import 'package:flutter/material.dart';
import 'package:aux_ui/widgets/nux_container.dart';

class NuxOverlay extends StatefulWidget {
  final String title;
  final Widget focusedWidget;
  final int topFlex;
  final double nudge;
  final Function closeOverlay;

  const NuxOverlay({
    Key key, 
    this.title,
    this.focusedWidget,
    this.topFlex = 6,
    this.nudge,
    this.closeOverlay,
  }) : super(key: key);

  _NuxOverlayState createState() => _NuxOverlayState();
}

class _NuxOverlayState extends State<NuxOverlay> {
  @override
  Widget build(BuildContext context) {
    return NuxContainer();
  }
}