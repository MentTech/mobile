// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editable_user_infor_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserInforEditorFormStore on _UserInforEditorFormStore, Store {
  Computed<bool>? _$canUpdateUserInforComputed;

  @override
  bool get canUpdateUserInfor => (_$canUpdateUserInforComputed ??=
          Computed<bool>(() => super.canUpdateUserInfor,
              name: '_UserInforEditorFormStore.canUpdateUserInfor'))
      .value;

  late final _$isForgotPasswordStateAtom = Atom(
      name: '_UserInforEditorFormStore.isForgotPasswordState',
      context: context);

  @override
  bool get isForgotPasswordState {
    _$isForgotPasswordStateAtom.reportRead();
    return super.isForgotPasswordState;
  }

  @override
  set isForgotPasswordState(bool value) {
    _$isForgotPasswordStateAtom.reportWrite(value, super.isForgotPasswordState,
        () {
      super.isForgotPasswordState = value;
    });
  }

  late final _$nameAtom =
      Atom(name: '_UserInforEditorFormStore.name', context: context);

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
      Atom(name: '_UserInforEditorFormStore.birthday', context: context);

  @override
  DateTime get birthday {
    _$birthdayAtom.reportRead();
    return super.birthday;
  }

  @override
  set birthday(DateTime value) {
    _$birthdayAtom.reportWrite(value, super.birthday, () {
      super.birthday = value;
    });
  }

  late final _$phoneAtom =
      Atom(name: '_UserInforEditorFormStore.phone', context: context);

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

  late final _$avatarAtom =
      Atom(name: '_UserInforEditorFormStore.avatar', context: context);

  @override
  String get avatar {
    _$avatarAtom.reportRead();
    return super.avatar;
  }

  @override
  set avatar(String value) {
    _$avatarAtom.reportWrite(value, super.avatar, () {
      super.avatar = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_UserInforEditorFormStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_UserInforEditorFormStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$_UserInforEditorFormStoreActionController =
      ActionController(name: '_UserInforEditorFormStore', context: context);

  @override
  void setName(String name) {
    final _$actionInfo = _$_UserInforEditorFormStoreActionController
        .startAction(name: '_UserInforEditorFormStore.setName');
    try {
      return super.setName(name);
    } finally {
      _$_UserInforEditorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBirthday(String birthday) {
    final _$actionInfo = _$_UserInforEditorFormStoreActionController
        .startAction(name: '_UserInforEditorFormStore.setBirthday');
    try {
      return super.setBirthday(birthday);
    } finally {
      _$_UserInforEditorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone(String phone) {
    final _$actionInfo = _$_UserInforEditorFormStoreActionController
        .startAction(name: '_UserInforEditorFormStore.setPhone');
    try {
      return super.setPhone(phone);
    } finally {
      _$_UserInforEditorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAvatar(String imageName) {
    final _$actionInfo = _$_UserInforEditorFormStoreActionController
        .startAction(name: '_UserInforEditorFormStore.setAvatar');
    try {
      return super.setAvatar(imageName);
    } finally {
      _$_UserInforEditorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateName(String value) {
    final _$actionInfo = _$_UserInforEditorFormStoreActionController
        .startAction(name: '_UserInforEditorFormStore.validateName');
    try {
      return super.validateName(value);
    } finally {
      _$_UserInforEditorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateBirthday(DateTime dateTime) {
    final _$actionInfo = _$_UserInforEditorFormStoreActionController
        .startAction(name: '_UserInforEditorFormStore.validateBirthday');
    try {
      return super.validateBirthday(dateTime);
    } finally {
      _$_UserInforEditorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePhone(String phoneNumber) {
    final _$actionInfo = _$_UserInforEditorFormStoreActionController
        .startAction(name: '_UserInforEditorFormStore.validatePhone');
    try {
      return super.validatePhone(phoneNumber);
    } finally {
      _$_UserInforEditorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateAvatar(String avatarName) {
    final _$actionInfo = _$_UserInforEditorFormStoreActionController
        .startAction(name: '_UserInforEditorFormStore.validateAvatar');
    try {
      return super.validateAvatar(avatarName);
    } finally {
      _$_UserInforEditorFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isForgotPasswordState: ${isForgotPasswordState},
name: ${name},
birthday: ${birthday},
phone: ${phone},
avatar: ${avatar},
success: ${success},
loading: ${loading},
canUpdateUserInfor: ${canUpdateUserInfor}
    ''';
  }
}

mixin _$FormErrorStore on _FormErrorStore, Store {
  Computed<bool>? _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_FormErrorStore.hasErrors'))
          .value;

  late final _$errorOnNameAtom =
      Atom(name: '_FormErrorStore.errorOnName', context: context);

  @override
  String? get errorOnName {
    _$errorOnNameAtom.reportRead();
    return super.errorOnName;
  }

  @override
  set errorOnName(String? value) {
    _$errorOnNameAtom.reportWrite(value, super.errorOnName, () {
      super.errorOnName = value;
    });
  }

  late final _$errorOnBirthdayAtom =
      Atom(name: '_FormErrorStore.errorOnBirthday', context: context);

  @override
  String? get errorOnBirthday {
    _$errorOnBirthdayAtom.reportRead();
    return super.errorOnBirthday;
  }

  @override
  set errorOnBirthday(String? value) {
    _$errorOnBirthdayAtom.reportWrite(value, super.errorOnBirthday, () {
      super.errorOnBirthday = value;
    });
  }

  late final _$errorOnPhoneAtom =
      Atom(name: '_FormErrorStore.errorOnPhone', context: context);

  @override
  String? get errorOnPhone {
    _$errorOnPhoneAtom.reportRead();
    return super.errorOnPhone;
  }

  @override
  set errorOnPhone(String? value) {
    _$errorOnPhoneAtom.reportWrite(value, super.errorOnPhone, () {
      super.errorOnPhone = value;
    });
  }

  late final _$errorOnAvatarAtom =
      Atom(name: '_FormErrorStore.errorOnAvatar', context: context);

  @override
  String? get errorOnAvatar {
    _$errorOnAvatarAtom.reportRead();
    return super.errorOnAvatar;
  }

  @override
  set errorOnAvatar(String? value) {
    _$errorOnAvatarAtom.reportWrite(value, super.errorOnAvatar, () {
      super.errorOnAvatar = value;
    });
  }

  @override
  String toString() {
    return '''
errorOnName: ${errorOnName},
errorOnBirthday: ${errorOnBirthday},
errorOnPhone: ${errorOnPhone},
errorOnAvatar: ${errorOnAvatar},
hasErrors: ${hasErrors}
    ''';
  }
}
