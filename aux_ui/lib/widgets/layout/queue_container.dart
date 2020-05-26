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

  QueueContainer({
    Key key, 
    this.title,
    this.child,
    this.titleWidget,
    this.height,
    this.width,
    this.margin,
    this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuxCard(
      height: this.height,
      width: this.width,
      constraints: this.constraints,
      margin: this.margin,
      borderColor: auxAccent,
      padding: 10.0,
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
                  padding: EdgeInsets.only(top: 5),
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
