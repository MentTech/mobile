import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/models/common/dart_enum/status_type_enum.dart';
import 'package:mobile/models/common/dart_enum/transaction_type_enum.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  int id;
  // int userId;
  int amount;
  TransactionType type;
  String message;
  StatusType status;
  // Null? relatedId;
  DateTime createAt;

  Transaction({
    required this.id,
    // required this.userId,
    required this.amount,
    required this.type,
    required this.message,
    required this.status,
    // required this.relatedId,
    required this.createAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

@JsonSerializable()
class TransactionContent {
  final List<Transaction> transactions;
  final int balance;

  TransactionContent({
    required this.balance,
    required this.transactions,
  });

  factory TransactionContent.fromJson(Map<String, dynamic> json) =>
      _$TransactionContentFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionContentToJson(this);
}
