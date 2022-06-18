extension StringExtension on int {
  String toTokenValueString() {
    if (this != 1) {
      return "$this token";
    }
    return "$this tokens";
  }
}
