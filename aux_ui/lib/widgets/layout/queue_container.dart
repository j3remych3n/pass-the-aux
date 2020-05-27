import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/layout/aux_card.dart';

class QueueContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget titleWidget;
  final double height;
  final double width;
  final BoxConstraints constraints;
  final EdgeInsets margin;
  final EdgeInsets padding;

  QueueContainer({
    Key key, 
    this.title,
    this.child,
    this.titleWidget,
    this.height,
    this.width,
    this.margin,
    this.constraints,
    this.padding,
  }) : super(key: key);

  EdgeInsets _defaultPadding() {
    if(this.padding == null) {
      return EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5);
    }
    return this.padding;
  }

  @override
  Widget build(BuildContext context) {
    return AuxCard(
      height: this.height,
      width: this.width,
      constraints: this.constraints,
      margin: this.margin,
      padding: _defaultPadding(),
      borderColor: auxAccent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  child: Text(this.title, style: auxDisp1),
                  padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * .5),
                )
              ),
              Align(
                alignment: Alignment.topRight,
                child: this.titleWidget,
              )
            ],
          ),
          Expanded(child: this.child)
        ]
      ),
    );
  }
}
