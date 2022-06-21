import 'package:intl/intl.dart';

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
    return DateFormat("dd/MM/yyyy").format(this);
  }
}

extension StringToDate on String {
  DateTime parseFromBithdayToString() {
    return DateFormat("dd/MM/yyyy").parse(this);
  }

  String parseFromBithdayToIso8601String() {
    return parseFromBithdayToString().toIso8601String();
  }
}
