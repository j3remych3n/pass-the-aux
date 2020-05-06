import 'package:flutter/material.dart';
import 'package:aux_ui/theme/colors.dart';
import 'package:aux_ui/theme/text.dart';
import './widgets/aux_card.dart';
import 'dart:io' show Platform;

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
  static EdgeInsets notchPadding;
  
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
    notchPadding = ( Platform.isIOS ) ? EdgeInsets.only(top: SizeConfig.notchHeight / 2, bottom: SizeConfig.notchHeight / 2) : EdgeInsets.only(top: SizeConfig.notchHeight); 
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
          padding: SizeConfig.notchPadding,
          child: AuxCard(
            borderColor: auxAccent,
            padding: 24.0,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
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
                    padding: EdgeInsets.only(top: 20),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: <Widget>[
                          TextField(
                            style: auxAccentButton,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.short_text, 
                                color:auxAccent,
                                size: 26.0,
                                semanticLabel: "Short text for user nickname",
                              ),
                              labelStyle: auxAccentButton,
                              labelText: 'enter a nickname',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(10), // TODO: scale by screen resolution
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(10), // TODO: scale by screen resolution
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Text('or', style: auxAccentButton)
                          ),
                          ButtonTheme(
                            minWidth: SizeConfig.safeBlockHorizontal * 100,
                            child: FlatButton(
                              onPressed:() {},
                              color: auxAccent,
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Image.asset('assets/spotify_logo.png', height: 21, width: 21),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text('sign up with spotify', strutStyle: StrutStyle(fontFamily: 'Larsseit', fontSize: 17, height: 1.2) ),
                                  ),
                                ],
                              ) 
                            ),
                          )
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
