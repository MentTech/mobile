extension StringExtension on int {
  String toTokenValueString({required String locale}) {
    if (1 == this && "en".compareTo(locale) == 0) {
      return "$this token";
    }
    return "$this tokens";
  }
}
