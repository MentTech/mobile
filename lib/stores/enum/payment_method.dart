// ignore_for_file: constant_identifier_names

enum PaymentMethod {
  Paypal,
  WireTransfer,
  Momo,
  ViettelPay,
  ZaloPay,
}

extension PaymentMethodExtension on PaymentMethod {
  String toTranslateCode() {
    return name.toLowerCase() + "_status_translate";
  }
}
