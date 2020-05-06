import 'package:flutter/material.dart';
import 'package:aux_ui/theme/colors.dart';

/*
  NAME         SIZE  WEIGHT  SPACING
headline1    96.0  light   -1.5
headline2    60.0  light   -0.5
headline3    48.0  normal   0.0
headline4    34.0  normal   0.25
headline5    24.0  normal   0.0
headline6    20.0  medium   0.15
subtitle1    16.0  normal   0.15
subtitle2    14.0  medium   0.1
body1        16.0  normal   0.5
body2        14.0  normal   0.25
button       14.0  medium   0.75
caption      12.0  normal   0.4
overline     10.0  normal   1.5
*/

// sign up & splash screens

// queue header
const primaryH1 = const TextStyle(
  color: AuxPrimary,
  fontWeight: FontWeight.w500,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 40
);

// section headers
const primaryH2 = const TextStyle(
  color: AuxPrimary,
  fontWeight: FontWeight.w500,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 29
);

// top song
const primaryH3 = const TextStyle(
  color: AuxPrimary,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 21
);

// song, general text
const primaryP1 = const TextStyle(
  color: AuxPrimary,
  fontWeight: FontWeight.w300,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 21
);

// buttons & textfields
const primaryP2 = const TextStyle(
  color: AuxPrimary,
  fontWeight: FontWeight.w500,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 17
);

const secondaryP2 = const TextStyle(
  color: AuxSecondary,
  fontWeight: FontWeight.w500,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 17
);

const tertiaryP2 = const TextStyle(
  color: AuxLGrey,
  fontWeight: FontWeight.w500,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 17
);

// details, small buttons
const primaryP3 = const TextStyle(
  color: AuxPrimary,
  fontWeight: FontWeight.w300,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 10
);