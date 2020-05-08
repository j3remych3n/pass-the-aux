import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/aux_card.dart';

class RegContainer extends StatelessWidget {
  RegContainer({
    Key key, 
    this.title,
    this.topWidget,
    this.bottomWidget,
    this.topFlex,
  }) : super(key: key);
  
  final String title;
  final Widget topWidget;
  final Widget bottomWidget;
  final int topFlex;

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Container(
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
                  flex: topFlex,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: this.topWidget,
                  )
                ),
                Expanded(
                  flex: 12-topFlex,
                  child: Padding(
                    padding: EdgeInsets.only(top: 25),
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
