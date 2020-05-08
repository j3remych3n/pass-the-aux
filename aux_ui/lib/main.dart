
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
// import 'package:aux_ui/screens/guest_signup.dart';
// import 'package:aux_ui/screens/host_reg.dart';
import 'package:aux_ui/screens/join_queue.dart';

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
        textTheme: auxTextTheme, // TODO add secondary text theme for alt buttons?
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: auxAccentButton,
          contentPadding: EdgeInsets.all(11),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(10), // TODO: scale by screen resolution
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(10), // TODO: scale by screen resolution
          ),
        ),
      ),
      home: JoinQueue(),
    );
  }
} 