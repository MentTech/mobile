import 'package:mobile/stores/message/message_store.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'deposit_token_form_store.g.dart';

class DepositTokenFormStore = _DepositTokenFormStore
    with _$DepositTokenFormStore;

abstract class _DepositTokenFormStore with Store {
  // store for handling form errors
  final ProgramRegisterErrorForm formErrorStore = ProgramRegisterErrorForm();

  // store for handling error messages
  final MessageStore messageStore = MessageStore();

  _DepositTokenFormStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => name, validateName),
      reaction((_) => email, validateEmail),
      reaction((_) => token, validateToken),
      reaction((_) => note, validateNote),
    ];
  }

  // store variables:-----------------------------------------------------------

  @observable
  String name = '';

  @observable
  String email = '';

  @observable
  String token = '';

  @observable
  String note = '';

  @computed
  bool get canLoadToken =>
      !formErrorStore.hasErrorsLoad &&
      name.isNotEmpty &&
      email.isNotEmpty &&
      token.isNotEmpty &&
      note.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setName(String value) {
    name = value;
  }

  @action
  void setEmail(String value) {
    email = value;
  }

  @action
  void setToken(String value) {
    token = value;
  }

  @action
  void setNote(String value) {
    note = value;
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
  void validateEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.email = "Email can't be empty";
    } else {
      formErrorStore.email = null;
    }
  }

  @action
  void validateToken(String value) {
    if (value.isEmpty) {
      formErrorStore.token = "Token can't be empty";
    } else if (!isNumeric(value)) {
      formErrorStore.token = "Token should be a Numeric";
    } else {
      formErrorStore.token = null;
    }
  }

  @action
  void validateNote(String value) {
    if (value.isEmpty) {
      formErrorStore.note =
          "You should give your more information to your mentor";
    } else {
      formErrorStore.note = null;
    }
  }

  // general methods:-----------------------------------------------------------
  Map<String, dynamic> toRequestJson() {
    return {
      "name": name,
      "email": email,
      "paymentMethod": "WireTransfer",
      "note": note,
      "token": int.parse(token),
    };
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validateName(name);
    validateEmail(email);
    validateToken(token);
    validateNote(note);
  }
}

class ProgramRegisterErrorForm = _ProgramRegisterErrorForm
    with _$ProgramRegisterErrorForm;

abstract class _ProgramRegisterErrorForm with Store {
  @observable
  String? name;

  @observable
  String? email;

  @observable
  String? token;

  @observable
  String? note;

  @computed
  bool get hasErrorsLoad =>
      name != null || email != null || token != null || note != null;
}
