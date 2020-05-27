import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/material.dart';

class RoundedActionButton extends StatelessWidget {
  final double height;
  final double width;
  final onPressed;
  final Color color;
  final Color borderColor;
  final String text;
  final TextStyle textStyle;

  RoundedActionButton(
    {
      this.height,
      this.width,
      this.onPressed,
      this.color = auxAccent,
      this.borderColor = Colors.transparent,
      this.text,
      this.textStyle = auxPrimaryButton
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(0),
        child: FlatButton(
            onPressed: onPressed,
            color: color,
            shape:
                StadiumBorder(side: BorderSide(color: borderColor, width: 3)),
            child: Text(text, style: textStyle)));
  }
}
