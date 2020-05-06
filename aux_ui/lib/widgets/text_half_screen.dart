import 'package:flutter/material.dart';
import 'package:aux_ui/theme/colors.dart';
import 'package:aux_ui/theme/text.dart';
import '../theme/size_config.dart';

class TextHalfScreenState extends State<TextHalfScreen> {
  List<Color> bgColorsPlain;
  List<Color> bgColorsGradient;
  List<Color> bgCurrent;
  bool pressed = false;

  Alignment childAlign(String orientation) {
    if (orientation == "top") return Alignment.bottomLeft;
    return Alignment.topRight;
  }

  TextAlign textAlign(String orientation) {
    if (orientation == "top") return TextAlign.left;
    return TextAlign.right;
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
    bgCurrent = bgColorsPlain;
  }

//  SizedBox(
//  width: double.infinity,
//  child: FlatButton.icon(
//  onPressed:() {},
//  color: auxAccent,
//  padding: EdgeInsets.all(15),
//  shape: RoundedRectangleBorder(
//  borderRadius: BorderRadius.circular(10)
//  ),
//  icon: new Image.asset('assets/spotify_logo.png', height: 21, width: 21),
//  label: Text('sign up with spotify')
//  ),

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      children: <Widget>[
        ButtonTheme(
          padding: EdgeInsets.all(15),
          minWidth: SizeConfig.safeBlockHorizontal * 100,
          child: Expanded(
              child: FlatButton(
                  onPressed:() {},
                  color: widget.background,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: this.childAlign(widget.orientation),
                        child: Text(widget.text, style: TextStyle(
                          // TODO: standardize this with theming
                            color: widget.textColor,
                            fontSize: 57,
                            fontWeight: FontWeight.w500), textAlign: this.textAlign(widget.orientation)),
                      ),
                    ],
                  )
              )),
        )
      ],
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

  TextHalfScreen(
      {Key key,
      @required this.orientation,
      @required this.background,
      @required this.textColor,
      @required this.changeOnPressed,
      @required this.text})
      : super(key: key);

  @override
  TextHalfScreenState createState() => TextHalfScreenState();
}
