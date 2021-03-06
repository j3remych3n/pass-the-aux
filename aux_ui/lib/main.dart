import 'package:aux_ui/routing/routing_constants.dart';
import 'package:aux_ui/routing/router.dart' as router;
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  runApp(AuxApp());
}

class AuxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'aux',
      onGenerateRoute: router.generateRoute,
      initialRoute: NuxIntroRoute,
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primaryColor: auxPrimary,
        accentColor: auxAccent,
        scaffoldBackgroundColor: auxPrimary,
        fontFamily: 'Larsseit',
        textTheme:
            auxTextTheme, // TODO add secondary text theme for alt buttons?
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: auxAccentButton,
          contentPadding: EdgeInsets.all(11),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            borderRadius:
                BorderRadius.circular(10), // TODO: scale by screen resolution
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            borderRadius:
                BorderRadius.circular(10), // TODO: scale by screen resolution
          ),
        ),
      ),
    );
  }
}
