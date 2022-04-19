extension DateTimeExtension on DateTime {
  DateTime subtractYear({required int year}) {
    return DateTime(this.year - year, month, day);
  }
}
