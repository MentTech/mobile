// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum StatusType {
  PENDING,
  SUCCESS,
  FAILED,
  HOLD,
}

extension StatusTypeExtension on StatusType {
  String toTranslateCode() {
    return name.toLowerCase() + "_status_translate";
  }

  Color toColorType() {
    switch (this) {
      case StatusType.PENDING:
        return Colors.yellow;
      case StatusType.SUCCESS:
        return Colors.green;
      case StatusType.FAILED:
        return Colors.red;
      default:
        // StatusType.HOLD
        return Colors.white;
    }
  }
}
