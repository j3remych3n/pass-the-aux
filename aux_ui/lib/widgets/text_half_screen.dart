import 'package:flutter/material.dart';
import 'package:aux_ui/theme/colors.dart';
import 'package:aux_ui/theme/text.dart';

class TextHalfScreenState extends State<TextHalfScreen> {
  TextHalfScreen screen;

  Alignment childAlign() {
    if (screen.orientation == "top") return Alignment.bottomLeft;
    return Alignment.topRight;
  }

  TextAlign textAlign() {
    if (screen.orientation == "top") return TextAlign.left;
    return TextAlign.right;
  }

  List<Color> gradientColors(bool pressed) {
    if (pressed) {
      return [screen.background, screen.background];
    } else {
      if (screen.orientation == "bottom") {
        return [auxBlurple, auxMagenta];
      }
      return [auxMagenta, auxBlurple];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: this.gradientColors(screen.pressed),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
      child: Align(
          alignment: this.childAlign(),
          child: Text(
            screen.text,
            style: TextStyle( // TODO: standardize this with theming
                color: screen.textColor, fontSize: 57, fontWeight: FontWeight.w500),
            textAlign: this.textAlign(),
          )),
    );
  }
}

class TextHalfScreen extends StatefulWidget {
  final String orientation;
  final Color background;
  final Color textColor;
  final bool changeOnPressed;
  final String text;

  var pressed = false;

  TextHalfScreen({Key key,
    @required this.orientation,
    @required this.background,
    @required this.textColor,
    @required this.changeOnPressed,
    @required this.text, }) : super(key: key);

  @override
  TextHalfScreenState createState() => TextHalfScreenState();
}

