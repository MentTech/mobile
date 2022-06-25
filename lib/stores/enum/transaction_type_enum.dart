// ignore_for_file: constant_identifier_names

enum TransactionType {
  TOPUP,
  WITHDRAW,
  APPLY,
  RECEIVE,
  TRANSFER,
}

extension TransactionTypeExtension on TransactionType {
  TransactionType toTransactionType({required String typeName}) {
    for (TransactionType transactionType in TransactionType.values) {
      if (transactionType.name.compareTo(typeName) == 0) {
        return transactionType;
      }
    }

    return TransactionType.TRANSFER;
  }

  String toTranslateCode() {
    return name.toLowerCase() + "_transaction_translate";
  }
}
