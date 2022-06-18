// ignore_for_file: constant_identifier_names

enum StatusType {
  PENDING,
  SUCCESS,
  FAILED,
  HOLD,
}

extension TransactionTypeExtension on StatusType {
  String toTranslateCode() {
    return name.toLowerCase() + "_status_translate";
  }
}
