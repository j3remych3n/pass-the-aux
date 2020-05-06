import 'package:flutter/material.dart';
import 'package:aux_ui/theme/colors.dart';
import 'package:aux_ui/theme/text.dart';
import './widgets/aux_card.dart';
import './widgets/text_half_screen.dart';
import 'theme/size_config.dart';

void main() => runApp(AuxApp());

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
          textTheme:
              auxTextTheme, // TODO add secondary text theme for alt buttons?
        ),
        home: GuestIntro());
  }
}

class GuestIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        height: SizeConfig.safeBlockVertical * 100,
        width: SizeConfig.safeBlockHorizontal * 100,
        child: Padding(
            padding: SizeConfig.notchPadding,
            child: AuxCard(
              borderColor: auxAccent,
              padding: 0.0,
              child: Stack(children: <Widget>[
                Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child: TextHalfScreen(
                          orientation: "top",
                          background: auxPrimary,
                          textStyle: auxDisp3,
                          text: "host\nan aux queue")),
                  Expanded(
                      child: TextHalfScreen(
                          orientation: "bottom",
                          background: auxAccent,
                          textStyle: auxDisp3Inv,
                          text: "join\nan aux queue"))
                ],
              ),
                Center(child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('or', style: auxDispMidAccent)
                )),
            ]))));
  }
}
