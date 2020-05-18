import 'package:aux_ui/named_routing/routing_constants.dart';
import 'package:flutter/material.dart';
import 'package:aux_ui/theme/aux_theme.dart';
import 'package:aux_ui/named_routing/router.dart' as router;
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  runApp(AuxApp());
}

class AuxApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'aux',
      onGenerateRoute: router.generateRoute,
      initialRoute: NuxIntroRoute,
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
//      home: HostSpotifyLink(),
    );
  }
}