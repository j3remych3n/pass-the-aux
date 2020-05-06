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
    return Card(
      child: Padding(
        padding: EdgeInsets.all(this.padding),  // TODO: scale by screen resolution
        child: this.child,
      ),
      margin: EdgeInsets.all(10),  // TODO: scale by screen resolution
      borderOnForeground: true,
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // TODO: scale by screen resolution
        side: BorderSide(
          color: this.borderColor, 
          width: 3, // TODO: scale by screen resolution
          style: BorderStyle.solid
        ),
      ),
    );
  }
}