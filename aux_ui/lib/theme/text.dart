import 'package:flutter/material.dart';
import 'package:aux_ui/theme/colors.dart';

/*
  VANILLA MATERIAL STANDARD FOR REFERENCE
  ---------------------------------------
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
  ---------------------------------------
*/

// sign up & splash screens
const auxDisp3 = const TextStyle(
  color: auxAccent,
  fontWeight: FontWeight.w500,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 56
);

// sign up & splash screens inverted
const auxDisp3Inv = const TextStyle(
    color: auxPrimary,
    fontWeight: FontWeight.w500,
    fontFamily: 'Larsseit',
    fontStyle:  FontStyle.normal,
    fontSize: 56
);

// queue header
const auxDisp2 = const TextStyle(
  color: auxAccent,
  fontWeight: FontWeight.w500,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 40
);

// section headers
const auxDisp1 = const TextStyle(
  color: auxAccent,
  fontWeight: FontWeight.w500,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 29
);

// "or" accent
const auxDispMidAccent = const TextStyle(
  color: auxAccent,
  fontWeight: FontWeight.w500,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 32
);

// top song
const auxHeadline = const TextStyle(
  color: auxAccent,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 21
);

// song, general text
const auxBody2 = const TextStyle(
  color: auxAccent,
  fontWeight: FontWeight.w300,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 21
);

// white on black: buttons & textfields
const auxAccentButton = const TextStyle(
  color: auxAccent,
  fontWeight: FontWeight.w500,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 17
);

// black on white: buttons & textfields
const auxPrimaryButton = const TextStyle(
  color: auxPrimary,
  fontWeight: FontWeight.w500,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 17
);

// grey on outline: buttons & textfields
const auxTertiaryButton = const TextStyle(
  color: auxLGrey,
  fontWeight: FontWeight.w500,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 17
);

// Small buttons & widgets
const auxCaption = const TextStyle(
  color: auxAccent,
  fontWeight: FontWeight.w500,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 10
);

// Detail text
const auxBody1 = const TextStyle(
  color: auxAccent,
  fontWeight: FontWeight.w300,
  fontFamily: 'Larsseit',
  fontStyle:  FontStyle.normal,
  fontSize: 10
);


// text theme
const auxTextTheme = TextTheme(
  display3: auxDisp3, // splash & registration text
  display2: auxDisp2, // queue header
  display1: auxDisp1, // section header
  headline: auxHeadline, // prominent song title
  body2: auxBody2, // song titles
  button: auxPrimaryButton, // button text (default black on white background)
  caption: auxCaption, // small buttons and widgets
  body1: auxBody1, // detail text (queue details, song details, etc.)
);