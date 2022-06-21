// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserInfoFormStore on _UserInfoFormStore, Store {
  Computed<bool>? _$canUpdateUserInforComputed;

  @override
  bool get canUpdateUserInfor => (_$canUpdateUserInforComputed ??=
          Computed<bool>(() => super.canUpdateUserInfor,
              name: '_UserInfoFormStore.canUpdateUserInfor'))
      .value;

  late final _$emailAtom =
      Atom(name: '_UserInfoFormStore.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$nameAtom =
      Atom(name: '_UserInfoFormStore.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$birthdayAtom =
      Atom(name: '_UserInfoFormStore.birthday', context: context);

  @override
  String get birthday {
    _$birthdayAtom.reportRead();
    return super.birthday;
  }

  @override
  set birthday(String value) {
    _$birthdayAtom.reportWrite(value, super.birthday, () {
      super.birthday = value;
    });
  }

  late final _$phoneAtom =
      Atom(name: '_UserInfoFormStore.phone', context: context);

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  late final _$_UserInfoFormStoreActionController =
      ActionController(name: '_UserInfoFormStore', context: context);

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_UserInfoFormStoreActionController.startAction(
        name: '_UserInfoFormStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_UserInfoFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String value) {
    final _$actionInfo = _$_UserInfoFormStoreActionController.startAction(
        name: '_UserInfoFormStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_UserInfoFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBirthday(String value) {
    final _$actionInfo = _$_UserInfoFormStoreActionController.startAction(
        name: '_UserInfoFormStore.setBirthday');
    try {
      return super.setBirthday(value);
    } finally {
      _$_UserInfoFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone(String value) {
    final _$actionInfo = _$_UserInfoFormStoreActionController.startAction(
        name: '_UserInfoFormStore.setPhone');
    try {
      return super.setPhone(value);
    } finally {
      _$_UserInfoFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateEmail(String value) {
    final _$actionInfo = _$_UserInfoFormStoreActionController.startAction(
        name: '_UserInfoFormStore.validateEmail');
    try {
      return super.validateEmail(value);
    } finally {
      _$_UserInfoFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateName(String value) {
    final _$actionInfo = _$_UserInfoFormStoreActionController.startAction(
        name: '_UserInfoFormStore.validateName');
    try {
      return super.validateName(value);
    } finally {
      _$_UserInfoFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateBirthday(String value) {
    final _$actionInfo = _$_UserInfoFormStoreActionController.startAction(
        name: '_UserInfoFormStore.validateBirthday');
    try {
      return super.validateBirthday(value);
    } finally {
      _$_UserInfoFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePhone(String value) {
    final _$actionInfo = _$_UserInfoFormStoreActionController.startAction(
        name: '_UserInfoFormStore.validatePhone');
    try {
      return super.validatePhone(value);
    } finally {
      _$_UserInfoFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
name: ${name},
birthday: ${birthday},
phone: ${phone},
canUpdateUserInfor: ${canUpdateUserInfor}
    ''';
  }
}

mixin _$UserFormErrorStore on _UserFormErrorStore, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_UserFormErrorStore.hasError'))
          .value;

  late final _$emailAtom =
      Atom(name: '_UserFormErrorStore.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$nameAtom =
      Atom(name: '_UserFormErrorStore.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$birthdayAtom =
      Atom(name: '_UserFormErrorStore.birthday', context: context);

  @override
  String? get birthday {
    _$birthdayAtom.reportRead();
    return super.birthday;
  }

  @override
  set birthday(String? value) {
    _$birthdayAtom.reportWrite(value, super.birthday, () {
      super.birthday = value;
    });
  }

  late final _$phoneAtom =
      Atom(name: '_UserFormErrorStore.phone', context: context);

  @override
  String? get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String? value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  @override
  String toString() {
    return '''
email: ${email},
name: ${name},
birthday: ${birthday},
phone: ${phone},
hasError: ${hasError}
    ''';
  }
}
