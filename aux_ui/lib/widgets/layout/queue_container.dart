import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/widgets/layout/aux_card.dart';

class QueueContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget titleWidget;
  final double minHeight;
  final double maxHeight;

  QueueContainer({
    Key key, 
    this.title,
    this.child,
    this.titleWidget,
    this.minHeight = 0.0,
    this.maxHeight = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuxCard(
      borderColor: auxAccent,
      padding: 10.0,
      child: Column(
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
          Row(
            children:<Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: this.child
                ),
          )
            ]
          )
        ],
      ),
    );
  }
}
