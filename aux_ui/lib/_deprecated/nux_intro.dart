
/*

import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import '../widgets/aux_card.dart';
import '../widgets/text_half_card.dart';

class NuxIntro extends StatelessWidget {
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
                          child: TextHalfCard(
                              orientation: "top",
                              background: auxPrimary,
                              textStyle: auxDisp3,
                              text: ">> host\nan aux queue")),
                      Expanded(
                          child: TextHalfCard(
                              orientation: "bottom",
                              background: auxAccent,
                              textStyle: auxDisp3Inv,
                              text: ">> join\nan aux queue"))
                    ],
                  ),
                  Center(child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('or', style: auxDispMidAccent)
                  )),
                ]))));
  }
}

*/