import 'package:aux_ui/theme/aux_theme.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class RoundedActionButton extends StatelessWidget {
  final double height;
  final double width;
  final Function onPressed;
  final Color color;
  final String text;
  final TextStyle textStyle;
  final Color borderColor;
  final bool bordered;

  const RoundedActionButton({
    this.height = 0,
    this.width,
    this.onPressed,
    this.color = auxAccent,
    this.bordered = true,
    this.borderColor = Colors.transparent,
    this.text = 'done',
    this.textStyle = auxPrimaryButton,
  });

  const RoundedActionButton.back({
    this.height = 0,
    this.width,
    this.onPressed,
    this.text = 'back',
    this.textStyle = auxTertiaryButton,
    this.color = Colors.black,
    this.bordered = true,
    this.borderColor = auxDGrey,
  });

  const RoundedActionButton.delete({
    this.height = 0,
    this.width,
    this.onPressed,
    this.text = 'delete',
    this.textStyle = auxPrimaryButton,
    this.color = Colors.red,
    this.bordered = false,
    this.borderColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
      height: max(SizeConfig.blockSizeVertical * 4.5, this.height),
      width: width,
      child: FlatButton(
        onPressed: onPressed,
        color: color,
        splashColor: (color == Colors.black) ? auxDDGrey : Colors.black26,
        shape: (bordered)
            ? StadiumBorder(
                side: BorderSide(
                  color: borderColor,
                  width: 3,
                ),
              )
            : StadiumBorder(),
        child: Text(
          text,
          style: textStyle,
          strutStyle: StrutStyle(fontSize: 17, height: 1.2),
        ),
      ),
    );
  }
}
