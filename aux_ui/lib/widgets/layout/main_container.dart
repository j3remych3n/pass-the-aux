import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'dart:math';

class MainContainer extends StatelessWidget  {

  final String title;
  final Widget header;
  final Widget footer;
  final List<Widget> body;
  static final Divider _bodySpacer = Divider(
    color: Colors.transparent,
    height: SizeConfig.blockSizeVertical);

  const MainContainer(
    {
      Key key,
      this.title,
      this.header,
      this.body,
      this.footer,
    }
  ) : super(key: key);

  @override
  build(BuildContext context) {
    return Material(
      child: Container(
        constraints: BoxConstraints.loose(
          Size.fromHeight(
            SizeConfig.safeAreaVertical
          )
        ),
        padding: SizeConfig.notchPadding,
        color: auxPrimary,
        child: SizedBox(
          height: SizeConfig.safeAreaVertical,
          width: SizeConfig.safeAreaHorizontal,
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 0.75),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 3.5, 
                    bottom: SizeConfig.blockSizeVertical * 0.25,
                    left: SizeConfig.blockSizeHorizontal * 4,
                    right: SizeConfig.blockSizeHorizontal * 4,
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(this.title, style: auxDisp2)
                  )
                ), 
                Container(
                  height: SizeConfig.blockSizeVertical * 2,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        child: this.header,
                      )
                    ],
                  )
                ),
                Expanded(
                  child: Padding(
                    padding:EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0.5),
                    child: Scaffold(
                      body: Column(
                        children: List<Widget>
                          .generate(
                            max(0, this.body.length * 2 - 1), 
                            (i) => (i.isEven) ? this.body[i ~/ 2] : _bodySpacer
                        )
                      ),
                      bottomSheet: Container(
                        margin: EdgeInsets.all(0),
                        width: SizeConfig.screenWidth,
                        constraints: BoxConstraints(
                          maxHeight: SizeConfig.blockSizeVertical * 15,
                          minHeight: SizeConfig.blockSizeVertical * 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [auxPrimary, auxPrimary, Colors.transparent],
                            stops: [0, 0.55, 1],
                          ),
                        ),
                        child: this.footer,
                      ),
                    )
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}