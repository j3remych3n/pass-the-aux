import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';

class ConfirmationNavButton extends StatelessWidget {
  final double height;
  final double width;
  final onPress;
  final Color color;
  final Color borderColor;
  final String text;
  final TextStyle textStyle;

  ConfirmationNavButton(
      {this.height, this.width, this.onPress, this.color, this.borderColor, this.text, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        padding: EdgeInsets.all(0),
        width: width,
        child: FlatButton(
            onPressed: onPress,
            color: color,
            shape: StadiumBorder(side: BorderSide(color: borderColor, width: 3)),
            child: Text(text, style: textStyle)));
  }
}
