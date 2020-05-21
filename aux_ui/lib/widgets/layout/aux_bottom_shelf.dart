import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';

class AuxBottomShelf extends StatelessWidget {
  AuxBottomShelf(
    { 
      this.child, 
      this.minHeight = 0,
      this.padding = 12.0,
    }
  );

  final child;
  final minHeight;
  final padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment(0, 0.6),
            colors: [Colors.white, Colors.transparent],
          )
        )
      )
    );
  }
}