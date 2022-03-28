// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Dimens {
  Dimens._();

  //for all screens
  static const double horizontal_padding = 12.0;
  static const double vertical_padding = 12.0;
  static const double horizontal_margin = 6.0;
  static const double vertical_margin = 6.0;

  /// Text dimens
  /// return size 15
  static const double more_small_text = 12;

  /// return size 15
  static const double small_text = 15;

  /// return size 20
  static const double medium_text = 20;

  /// return size 25
  static const double large_text = 25;

  /// return size 30
  static const double extra_large_text = 30;

  static const double text_field_height = 50.0;

  /// Elevation
  /// return size 5.0
  static const double normalElevation = 5.0;

  /// return size 10.0
  static const double highElevation = 10.0;

  // BorderRadius
  static BorderRadius kBorderRadius = BorderRadius.circular(5);
  static BorderRadius kMaxBorderRadius = BorderRadius.circular(20);
}
