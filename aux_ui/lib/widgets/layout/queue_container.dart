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
    SizeConfig().init(context);
    return AuxCard(
      borderColor: auxAccent,
      padding: 15.0,
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
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5, top: 15),
            child: this.child,
          )
        ],
      ),
    );
  }
}
