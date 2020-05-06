import 'package:flutter/material.dart';
import 'package:aux_ui/theme/colors.dart';
import 'package:aux_ui/theme/text.dart';
import './widgets/aux_card.dart';
import './widgets/text_half_screen.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal = _mediaQueryData.padding.left +
        _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top +
        _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Container hostQueue = Container(
      child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            "host\nan aux queue",
            style: TextStyle(
                color: auxAccent, fontSize: 57, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          )),
      color: auxPrimary);

  Container joinQueue = Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFCC00FF), Color(0xFF4200FF)],
              begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
      ),
      child: Align(
          alignment: Alignment.topRight,
          child: Text(
            "join\nan aux queue",
            style: TextStyle(
                color: Colors.black, fontSize: 57, fontWeight: FontWeight.w500),
            textAlign: TextAlign.right,
          )),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        body: Center(
          child: Container(
              child: Column(children: <Widget>[
            Expanded(
                child: hostQueue),
            Expanded(
                child: joinQueue),
          ])),
        ),
      ),
    );
  }
}
