import 'package:flutter/material.dart';

abstract class SequentialWidget extends StatefulWidget {
  final String nextPage;
  final String backPage;

  const SequentialWidget({Key key, this.nextPage, this.backPage}) : super(key: key);

  void next(BuildContext ctx, {Object arguments}) {
    if (this.nextPage != null) Navigator.pushNamed(ctx, nextPage, arguments: arguments);
  }

  void nextReplace(BuildContext ctx, {Object arguments}) {
    if (this.nextPage != null) Navigator.pushReplacementNamed(ctx, nextPage, arguments: arguments);
  }
  
  void back(BuildContext ctx, {Object arguments}) {
    if (this.backPage != null) Navigator.pushNamed(ctx, backPage, arguments: arguments);
  }
}