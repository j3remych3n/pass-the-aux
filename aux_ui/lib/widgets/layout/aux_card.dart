import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';

class AuxCard extends StatelessWidget {
  AuxCard(
    { 
      this.child, 
      this.borderColor = auxLGrey,
      this.padding = const EdgeInsets.all(12.0),
      this.margin = const EdgeInsets.all(6.0),
      this.width,
      this.height,
      this.constraints,
    }
  );

  final child;
  final borderColor;
  final EdgeInsets padding;
  final double width;
  final double height;
  final BoxConstraints constraints;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Material(
      color: Colors.transparent,
        child: Container(
          width: this.width,
          height: this.height,
          constraints: this.constraints,
          padding: this.padding,
          child: this.child,
          margin: this.margin,  // TODO: scale by screen resolution
          decoration: BoxDecoration(
            border: Border.all(
              color: this.borderColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          )
        )
    );
  }
}