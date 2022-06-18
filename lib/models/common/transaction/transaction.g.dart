// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['id'] as int,
      amount: json['amount'] as int,
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      message: json['message'] as String,
      status: $enumDecode(_$StatusTypeEnumMap, json['status']),
      createAt: DateTime.parse(json['createAt'] as String),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'type': _$TransactionTypeEnumMap[instance.type],
      'message': instance.message,
      'status': _$StatusTypeEnumMap[instance.status],
      'createAt': instance.createAt.toIso8601String(),
    };

const _$TransactionTypeEnumMap = {
  TransactionType.TOPUP: 'TOPUP',
  TransactionType.WITHDRAW: 'WITHDRAW',
  TransactionType.APPLY: 'APPLY',
  TransactionType.RECEIVE: 'RECEIVE',
  TransactionType.TRANSFER: 'TRANSFER',
};

const _$StatusTypeEnumMap = {
  StatusType.PENDING: 'PENDING',
  StatusType.SUCCESS: 'SUCCESS',
  StatusType.FAILED: 'FAILED',
  StatusType.HOLD: 'HOLD',
};
