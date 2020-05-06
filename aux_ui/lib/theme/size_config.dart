import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double safeAreaHorizontal;
  static double safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;
  static double notchHeight;
  static EdgeInsets notchPadding;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    safeAreaHorizontal = _mediaQueryData.padding.left +
        _mediaQueryData.padding.right;
    safeAreaVertical = _mediaQueryData.padding.top +
        _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - safeAreaVertical) / 100;
    notchHeight = safeAreaVertical;
    notchPadding = ( Platform.isIOS ) ? EdgeInsets.only(top: SizeConfig.notchHeight / 2, bottom: SizeConfig.notchHeight / 2) : EdgeInsets.only(top: SizeConfig.notchHeight);
  }
}