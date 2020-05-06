import 'package:flutter/material.dart';
import 'package:aux_ui/theme/colors.dart';

class AuxCard extends StatelessWidget {
  AuxCard(
    { 
      this.child, 
      this.border = const BorderSide(
          color: auxLGrey, 
          width: 3, // TODO: scale by screen resolution
          style: BorderStyle.solid
        )
    }
  );

  var child;
  var border;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: this.child,
      borderOnForeground: true,
      color: auxPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // TODO: scale by screen resolution
        side: this.border,
      ),
    );
  }
}