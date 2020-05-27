import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/layout/aux_card.dart';

class NuxContainer extends StatelessWidget {
  final String title;
  final Widget topWidget;
  final Widget bottomWidget;
  final int topFlex;

  NuxContainer({
    Key key, 
    this.title,
    this.topWidget,
    this.bottomWidget,
    this.topFlex = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Container(
      color: auxPrimary,
      child: Padding(
          padding: SizeConfig.notchPadding,
          child: AuxCard(
            borderColor: auxAccent,
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
            margin: EdgeInsets.all(SizeConfig.blockSizeVertical * 0.75),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: this.topFlex,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: this.topWidget,
                  )
                ),
                Expanded(
                  flex: 12 - this.topFlex,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: this.bottomWidget,
                  )
                )
              ], 
            ),
          )
        )
    );
  }
}
