import 'package:aux_ui/theme/colors.dart';
import 'package:aux_ui/theme/text.dart';
import 'package:flutter/material.dart';

const auxTheme = ThemeData(
  primaryColor: AuxSecondary,
  accentColor: AuxPrimary,

  fontFamily: 'Larsseit',

  textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  )
);