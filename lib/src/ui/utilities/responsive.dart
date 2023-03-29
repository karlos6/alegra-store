// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:ui';

class Adapt {
  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
  static final double _width = mediaQuery.size.width;
  static final double _height = mediaQuery.size.height;

  static px(number) {
    return number * (mediaQuery.size.height / 1080);
  }

  static screenW() {
    return _width;
  }

  static screenH() {
    return _height;
  }

  static double wp(percentage, BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double result = (percentage * width) / 100;
    return result;
  }

  static double hp(percentage, BuildContext context) {
    final heigth = MediaQuery.of(context).size.height;
    double result = (percentage * heigth) / 100;
    return result;
  }
}
