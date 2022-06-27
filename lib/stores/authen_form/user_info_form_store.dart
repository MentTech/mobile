import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';
import 'package:mobile/utils/extension/datetime_extension.dart';

part 'user_info_form_store.g.dart';

class UserInfoFormStore = _UserInfoFormStore with _$UserInfoFormStore;

abstract class _UserInfoFormStore with Store {
  // store for handling form errors
  final UserFormErrorStore formErrorStore = UserFormErrorStore();

  _UserInfoFormStore({
    required this.email,
    required this.name,
    required this.birthday,
    required this.phone,
  }) {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => email, validateEmail),
      reaction((_) => name, validateName),
      reaction((_) => birthday, validateBirthday),
      reaction((_) => phone, validatePhone),
    ];
  }

  // store variables:-----------------------------------------------------------

  @observable
  String email;

  @observable
  String name;

  @observable
  String birthday;

  @observable
  String phone;

  @computed
  bool get canUpdateUserInfor =>
      !formErrorStore.hasError &&
      email.isNotEmpty &&
      name.isNotEmpty &&
      birthday.isNotEmpty &&
      phone.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setEmail(String value) {
    email = value;
  }

  @action
  void setName(String value) {
    name = value;
  }

  @action
  void setBirthday(String value) {
    birthday = value;
  }

  @action
  void setPhone(String value) {
    phone = value;
  }

  @action
  void validateEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.email = "Email can't be empty";
    } else if (!isEmail(value)) {
      formErrorStore.email = 'Please enter a valid email address';
    } else {
      formErrorStore.email = null;
    }
  }

  @action
  void validateName(String value) {
    if (value.isEmpty) {
      formErrorStore.name = "Name can't be empty";
    } else {
      formErrorStore.name = null;
    }
  }

  @action
  void validateBirthday(String value) {
    if (value.isEmpty) {
      formErrorStore.birthday = "Birthday can't be empty";
    } else if (!value.isBirthdayString()) {
      formErrorStore.birthday = "This is a invalid date";
    } else {
      formErrorStore.birthday = null;
    }
  }

  @action
  void validatePhone(String value) {
    if (value.isEmpty) {
      formErrorStore.phone = "Phone password can't be empty";
    } else if (value.length < 10) {
      formErrorStore.phone = "Phone is too short";
    } else if (value.length > 12) {
      formErrorStore.phone = "Phone is too long";
    } else {
      formErrorStore.phone = null;
    }
  }

  // general methods:-----------------------------------------------------------
  Map<String, String> toDataJson() {
    return {
      "email": email,
      "name": name,
      "birthday": birthday.parseFromBithdayToIso8601String(),
      "phone": phone,
    };
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validateEmail(email);
    validateName(name);
    validateBirthday(birthday);
    validatePhone(phone);
  }
}

class UserFormErrorStore = _UserFormErrorStore with _$UserFormErrorStore;

abstract class _UserFormErrorStore with Store {
  @observable
  String? email;

  @observable
  String? name;

  @observable
  String? birthday;

  @observable
  String? phone;

  @computed
  bool get hasError =>
      email != null && name != null && birthday != null && phone != null;
}
