import 'package:flutter/material.dart';
import 'package:aux_ui/theme/colors.dart';
import 'package:aux_ui/theme/text.dart';
import 'screens/nux_intro.dart';

void main() => runApp(AuxApp());

class AuxApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'aux',
        theme: ThemeData(
        primaryColor: auxPrimary,
        accentColor: auxAccent,
        scaffoldBackgroundColor: auxPrimary,
          fontFamily: 'Larsseit',
          textTheme:
              auxTextTheme, // TODO add secondary text theme for alt buttons?
        ),
        home: NuxIntro());
  }
}
