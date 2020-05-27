import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';

class AuxBottomShelf extends StatelessWidget {
  AuxBottomShelf(
    { 
      this.child, 
    }
  );

  final child;
  // final minHeight;
  // final padding;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [auxPrimary, auxPrimary, Colors.transparent],
            stops: [0, 0.60, 1],
          ),
        ),
    );
  }
}