import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';

class _TextHalfCardState extends State<TextHalfCard> {
  List<Color> bgColorsPlain;
  List<Color> bgColorsGradient;
  bool pressed = false;
  BorderRadius radii;
  Alignment childAlignment;
  TextAlign textAlignment;

  void childAlign(String orientation) {
    if (orientation == "top") {
      childAlignment = Alignment.bottomLeft;
    } else {
      childAlignment = Alignment.topRight;
    }
  }

  void textAlign(String orientation) {
    if (orientation == "top") {
      textAlignment = TextAlign.left;
    } else {
      textAlignment = TextAlign.right;
    }
  }

  void setRadii(String orientation) {
    if (orientation == "top") {
      radii = BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0));
    } else {
      radii = BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10));
    }
  }

  @override
  void initState() {
    super.initState();
    bgColorsPlain = [widget.background, widget.background];
    if (widget.orientation == "bottom") {
      bgColorsGradient = [auxBlurple, auxMagenta];
    } else {
      bgColorsGradient = [auxMagenta, auxBlurple];
    }
    setRadii(widget.orientation);
    childAlign(widget.orientation);
    textAlign(widget.orientation);
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
        decoration: new BoxDecoration(
          borderRadius: radii,
          gradient: new LinearGradient(
            colors: pressed ? bgColorsGradient : bgColorsPlain,
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            ButtonTheme(
              padding: EdgeInsets.all(15),
              minWidth: SizeConfig.safeBlockHorizontal * 100,
              child: Expanded(
                  child: FlatButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: <Widget>[
                          GestureDetector(onTapUp: (TapUpDetails detail) {
                            setState(() {
                              pressed = !pressed;
                            });
                          }, onTapDown: (TapDownDetails detail) {
                            setState(() {
                              pressed = !pressed;
                            });
                          }),
                          Align(
                            alignment: childAlignment,
                            child: Text(widget.text,
                                style: TextStyle(color: pressed ? widget.background : widget.textStyle.color,
                                fontWeight: widget.textStyle.fontWeight,
                                fontFamily: widget.textStyle.fontFamily,
                                fontStyle: widget.textStyle.fontStyle,
                                fontSize: widget.textStyle.fontSize),
                                textAlign: textAlignment),
                          ),
                        ],
                      ))),
            )
          ],
        ));
  }
}

class TextHalfCard extends StatefulWidget {
  final String orientation;
  final Color background;
  final TextStyle textStyle;
  final String text;

  TextHalfCard(
      {Key key,
      @required this.orientation,
      @required this.background,
      @required this.textStyle,
      @required this.text})
      : super(key: key);

  @override
  _TextHalfCardState createState() => _TextHalfCardState();
}
