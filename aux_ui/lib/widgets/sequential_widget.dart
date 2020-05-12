import 'package:flutter/material.dart';

abstract class SequentialWidget extends StatefulWidget {
  String nextPage;
  String prevPage;

  const SequentialWidget({
    Key key, 
    String nextPage,
    String prevPage,
  }) : super(key: key);

  void next(BuildContext ctx, {Object arguments}) {
    if (this.nextPage != null) Navigator.pushNamed(ctx, nextPage, arguments: arguments);
  }

  void nextReplace(BuildContext ctx, {Object arguments}) {
    if (this.nextPage != null) Navigator.pushReplacementNamed(ctx, nextPage, arguments: arguments);
  }
  
  void back(BuildContext ctx, {Object arguments}) {
    if (this.prevPage != null) Navigator.pushNamed(ctx, prevPage, arguments: arguments);
  }
}