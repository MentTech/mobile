import 'package:intl/intl.dart';
import 'package:mobile/utils/extension/datetime_extension.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'editable_user_infor_form_store.g.dart';

class UserInforEditorFormStore = _UserInforEditorFormStore
    with _$UserInforEditorFormStore;

abstract class _UserInforEditorFormStore with Store {
  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  _UserInforEditorFormStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  // setup reaction
  void _setupValidations() {
    _disposers = [
      reaction((_) => name, validateName),
      reaction((_) => birthday, validateBirthday),
      reaction((_) => phone, validatePhone),
      reaction((_) => avatar, validateAvatar),
    ];
  }

  // store variables:-----------------------------------------------------------

  @observable
  bool isForgotPasswordState = false;

  @observable
  String name = '';

  @observable
  DateTime birthday = DateTime.now();

  @observable
  String phone = '';

  @observable
  String avatar = 'avatar.png';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @computed
  bool get canUpdateUserInfor =>
      !formErrorStore.hasErrors &&
      name.isNotEmpty &&
      !DateTime.now().isAtSameMomentAs(birthday) &&
      phone.isNotEmpty &&
      avatar.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setName(String name) {
    this.name = name;
  }

  @action
  void setBirthday(String birthday) {
    this.birthday = DateFormat("").parse(birthday);
  }

  @action
  void setPhone(String phone) {
    this.phone = phone;
  }

  @action
  void setAvatar(String imageName) {
    avatar = imageName;
  }

  @action
  void validateName(String value) {
    if (value.isEmpty) {
      formErrorStore.errorOnName = "Confirm name can't be empty";
    } else {
      formErrorStore.errorOnName = null;
    }
  }

  // set up
  @action
  void validateBirthday(DateTime dateTime) {
    if (dateTime.isBefore(DateTime.now().subtractYear(year: 13))) {
      formErrorStore.errorOnBirthday = "You must be over 13 years old";
    } else {
      formErrorStore.errorOnBirthday = null;
    }
  }

  @action
  void validatePhone(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      formErrorStore.errorOnPhone = "Phone number can't be empty";
    } else if (isNumeric(phoneNumber)) {
      formErrorStore.errorOnPhone = "Invalid phone number";
    } else if (phoneNumber.length != 10) {
      formErrorStore.errorOnPhone = "Phone number has 10 digits";
    } else {
      formErrorStore.errorOnPhone = null;
    }
  }

  @action
  void validateAvatar(String avatarName) {}

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  Map<String, dynamic> toParameter({required String email}) {
    return {
      "email": email,
      "name": name,
      "birthday": birthday,
      "phone": phone,
    };
  }

  void validateAll() {
    validateName(name);
    validateBirthday(birthday);
    validatePhone(phone);
    validateAvatar(avatar);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String? errorOnName;

  @observable
  String? errorOnBirthday;

  @observable
  String? errorOnPhone;

  @observable
  String? errorOnAvatar;

  @computed
  bool get hasErrors =>
      errorOnName != null ||
      errorOnBirthday != null ||
      errorOnPhone != null ||
      errorOnAvatar != null;
}
