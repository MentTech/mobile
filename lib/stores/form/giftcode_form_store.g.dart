// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'giftcode_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GiftcodeFormStore on _GiftcodeFormStore, Store {
  Computed<bool>? _$canApplyGiftcodeComputed;

  @override
  bool get canApplyGiftcode => (_$canApplyGiftcodeComputed ??= Computed<bool>(
          () => super.canApplyGiftcode,
          name: '_GiftcodeFormStore.canApplyGiftcode'))
      .value;

  late final _$giftcodeAtom =
      Atom(name: '_GiftcodeFormStore.giftcode', context: context);

  @override
  String get giftcode {
    _$giftcodeAtom.reportRead();
    return super.giftcode;
  }

  @override
  set giftcode(String value) {
    _$giftcodeAtom.reportWrite(value, super.giftcode, () {
      super.giftcode = value;
    });
  }

  late final _$_GiftcodeFormStoreActionController =
      ActionController(name: '_GiftcodeFormStore', context: context);

  @override
  void setApplyGiftcode(String value) {
    final _$actionInfo = _$_GiftcodeFormStoreActionController.startAction(
        name: '_GiftcodeFormStore.setApplyGiftcode');
    try {
      return super.setApplyGiftcode(value);
    } finally {
      _$_GiftcodeFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateGiftcode(String value) {
    final _$actionInfo = _$_GiftcodeFormStoreActionController.startAction(
        name: '_GiftcodeFormStore.validateGiftcode');
    try {
      return super.validateGiftcode(value);
    } finally {
      _$_GiftcodeFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
giftcode: ${giftcode},
canApplyGiftcode: ${canApplyGiftcode}
    ''';
  }
}

mixin _$GiftcodeErrorForm on _GiftcodeErrorForm, Store {
  Computed<bool>? _$hasErrorsApplyComputed;

  @override
  bool get hasErrorsApply =>
      (_$hasErrorsApplyComputed ??= Computed<bool>(() => super.hasErrorsApply,
              name: '_GiftcodeErrorForm.hasErrorsApply'))
          .value;

  late final _$giftcodeAtom =
      Atom(name: '_GiftcodeErrorForm.giftcode', context: context);

  @override
  String? get giftcode {
    _$giftcodeAtom.reportRead();
    return super.giftcode;
  }

  @override
  set giftcode(String? value) {
    _$giftcodeAtom.reportWrite(value, super.giftcode, () {
      super.giftcode = value;
    });
  }

  @override
  String toString() {
    return '''
giftcode: ${giftcode},
hasErrorsApply: ${hasErrorsApply}
    ''';
  }
}
