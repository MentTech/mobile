import 'package:flutter/material.dart';
import 'package:mobile/utils/locale/app_localization.dart';

enum OrderType {
  asc,
  desc,
}

extension ParseOrderTypeToString on OrderType {
  String toLocaleString(BuildContext context) {
    return AppLocalizations.of(context)
        .translate(toString().split('.').last + "_sort_translate");
  }
}

enum OrderByType {
  name,
  createAt,
}

extension ParseOrderByTypeToString on OrderByType {
  String toLocaleString(BuildContext context) {
    return AppLocalizations.of(context)
        .translate(toString().split('.').last + "_orderby_translate");
  }
}
