import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';

class AuxCard extends StatelessWidget {
  AuxCard(
    { 
      this.child, 
      this.borderColor = auxLGrey,
      this.padding = 12.0,
    }
  );

  final child;
  final borderColor;
  final padding;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Material(
      color: Colors.transparent,
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(this.padding),  // TODO: scale by screen resolution
          child: this.child,
        ),
        margin: const EdgeInsets.all(6),  // TODO: scale by screen resolution
        constraints: BoxConstraints.loose(
          Size(
            SizeConfig.safeAreaHorizontal,
            SizeConfig.safeAreaVertical
            )
          ),
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