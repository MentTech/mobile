import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mobile/utils/locale/app_localization.dart';

extension DateTimeExtension on DateTime {
  DateTime subtractYear({required int year}) {
    return DateTime(this.year - year, month, day);
  }

  String toFulltimeString() {
    return DateFormat("hh:mm:ss, dd/MM/yyyy").format(this);
  }

  String toDateTimeDealString() {
    return DateFormat("dd/MM/yyyy, hh:mm:ss a").format(this);
  }

  String toBirthdayString() {
    return DateFormat("yyyy-MM-dd").format(this);
  }

  String toDateString() {
    return DateFormat("dd/MM/yyyy").format(this);
  }

  String toMMMMYYYYLocaleString(BuildContext context) {
    return DateFormat(
            "MMMM yyyy", AppLocalizations.of(context).locale.languageCode)
        .format(this)
        .capitalizeFirstCharacter();
  }
}

extension StringToDate on String {
  DateTime parseFromBithdayString({bool utc = false}) {
    return DateFormat("dd/MM/yyyy").parse(this, utc);
  }

  bool isBirthdayString() {
    final isBirthdayStringForm =
        (RegExp(r'\d\d\/\d\d\/\d+').firstMatch(this)?.group(0)?.length ?? -1) ==
            length;

    bool isDateString = false;
    try {
      DateFormat("dd/MM/yyyy").parse(this);

      isDateString = true;
    } catch (e) {
      isDateString = false;
    }

    return isBirthdayStringForm && isDateString;
  }

  String parseFromBithdayToIso8601String() {
    return parseFromBithdayString(utc: true).toIso8601String();
  }

  String capitalizeFirstCharacter() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
