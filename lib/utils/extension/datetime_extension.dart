import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mobile/utils/locale/app_localization.dart';

extension DateTimeExtension on DateTime {
  DateTime subtractYear({required int year}) {
    return DateTime(this.year - year, month, day);
  }

  DateTime tomorrow({bool toUTC = false}) {
    if (toUTC) {
      return DateTime(year, month, day + 1).toUtc();
    } else {
      return DateTime(year, month, day + 1).toLocal();
    }
  }

  DateTime today({bool toUTC = false}) {
    if (toUTC) {
      return DateTime(year, month, day).toUtc();
    } else {
      return DateTime(year, month, day).toLocal();
    }
  }

  DateTime before({required Duration duration, bool toUTC = false}) {
    if (toUTC) {
      return subtract(duration).toUtc();
    } else {
      return subtract(duration).toLocal();
    }
  }

  String toHms({bool toUTC = false}) {
    return DateFormat.Hms().format(toUTC ? toUtc() : toLocal());
  }

  String toFulltimeString() {
    return DateFormat("hh:mm:ss, dd/MM/yyyy").format(this);
  }

  String toPresentedTime({bool toUTC = false}) {
    return DateFormat("hh:mm:ss").format(toUTC ? toUtc() : toLocal());
  }

  String toMeridiemPattern({bool toUTC = false}) {
    return DateFormat("a").format(toUTC ? toUtc() : toLocal());
  }

  String toDateTimeDealString() {
    return DateFormat("dd/MM/yyyy, hh:mm:ss a").format(this);
  }

  String toZDateString({bool toUTC = false}) {
    return DateFormat("yyyy-MM-dd").format(toUTC ? toUtc() : toLocal());
  }

  String toDDMMYYYYString({bool toUTC = false}) {
    return DateFormat("dd/MM/yyyy").format(toUTC ? toUtc() : toLocal());
  }

  String toMonthNameString({String? locale}) {
    return DateFormat("MMM", locale).format(this);
  }

  String toMMMMYYYYLocaleString(BuildContext context) {
    return DateFormat(
            "MMMM yyyy", AppLocalizations.of(context).locale.languageCode)
        .format(this)
        .capitalizeFirstCharacter();
  }
}

extension StringToDate on String {
  DateTime parseFromDDMMYYYYString({bool utc = false}) {
    return DateFormat("dd/MM/yyyy").parse(this, utc);
  }

  bool isDDMMYYYYString() {
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

  String parseFromDDMMYYYYToIso8601String() {
    return parseFromDDMMYYYYString(utc: true).toIso8601String();
  }

  String capitalizeFirstCharacter() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
