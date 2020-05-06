import 'package:flutter/material.dart';
import 'package:aux_ui/theme/colors.dart';
import 'package:aux_ui/theme/text.dart';
import './widgets/aux_card.dart';

void main() => runApp(AuxApp());

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  
  static double safeAreaHorizontal;
  static double safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;
  static double notchHeight;
  
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    
    safeAreaHorizontal = _mediaQueryData.padding.left + 
    _mediaQueryData.padding.right;
    safeAreaVertical = _mediaQueryData.padding.top +
    _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - safeAreaVertical) / 100;
    notchHeight = safeAreaVertical;
  }
}


class AuxApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'aux',
      theme: ThemeData(
        primaryColor: auxPrimary,
        accentColor: auxAccent,
        scaffoldBackgroundColor: auxPrimary,
        fontFamily: 'Larsseit',
        textTheme: auxTextTheme, // TODO add secondary text theme for alt buttons?
      ),
      home: GuestRegName(title: 'aux'),
    );
  }
}

class GuestRegName extends StatefulWidget {
  GuestRegName({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _GuestRegState createState() => _GuestRegState();
}

class _GuestRegState extends State<GuestRegName> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.safeBlockVertical * 100,
      width: SizeConfig.safeBlockHorizontal * 100,
      color: auxPrimary,
      child: Padding(
          padding: EdgeInsets.only(top: SizeConfig.notchHeight),
          child: AuxCard(
            borderColor: auxAccent,
            padding: 30.0,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "first,\nlet's get a name!", 
                        style: auxDisp3
                      )
                    )
                  )
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: <Widget>[
                          Text('placeholder 1'),
                          Text('placeholder 2'),
                        ],
                      )
                    )
                  )
                )
              ], 
            ),
          )
        )
    );
  }
}
