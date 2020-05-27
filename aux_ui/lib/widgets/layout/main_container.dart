import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'dart:math';

class MainContainer extends StatelessWidget  {

  final String title;
  final Widget headerWidget;
  final Widget bottomWidget;
  final List<Widget> body;
  final List<bool> expanded;
  static final Divider _bodySpacer = Divider(
    color: Colors.transparent,
    height: SizeConfig.blockSizeVertical);

  const MainContainer(
    {
      Key key,
      this.title,
      this.headerWidget,
      this.body,
      this.bottomWidget,
      this.expanded,
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
                    top: SizeConfig.blockSizeVertical * 5, 
                    bottom: SizeConfig.blockSizeVertical * 0.5,
                    left: SizeConfig.blockSizeHorizontal * 4,
                    right: SizeConfig.blockSizeHorizontal * 4,
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(this.title, style: auxDisp2)
                  )
                ), 
                SizedBox(
                  width: SizeConfig.safeAreaHorizontal,
                  height: SizeConfig.blockSizeVertical * 1.5,
                  child: this.headerWidget,
                ),
                Expanded(
                  child: Column(
                    children: List<Widget>
                      .generate(
                        max(0, this.body.length * 2 - 1), 
                        (i) => (i.isEven) ? this.body[i ~/ 2] : _bodySpacer
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}