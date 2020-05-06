import 'package:flutter/material.dart';
import 'package:aux_ui/theme/colors.dart';

class AuxCard extends StatelessWidget {
  AuxCard(
    { 
      this.child, 
      this.borderColor = auxLGrey,
      this.padding = 12.0,
    }
  );

// outer padding = ~12 pix
// inner = ~ 12 px / 25 px

  var child;
  var borderColor;
  var border;
  var padding;

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