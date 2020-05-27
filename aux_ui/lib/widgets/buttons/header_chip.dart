import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';

class HeaderChip extends StatelessWidget {
  final IconData iconName;
  final String text;
  final Color color;

  const HeaderChip({Key key, this.iconName, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 16), // TODO: scale or finalize
        child: Row(
          children: <Widget>[
            Icon(iconName, color: color, size: 10),
            Padding(
                padding: EdgeInsets.only(left: 1),
                child: Text(text, style: auxBody1))
          ],
        ));
  }
}