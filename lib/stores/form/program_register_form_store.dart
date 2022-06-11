import 'dart:developer';

import 'package:mobile/stores/common/common_store.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobx/mobx.dart';

part 'program_register_form_store.g.dart';

class ProgramRegisterFormStore = _ProgramRegisterFormStore
    with _$ProgramRegisterFormStore;

abstract class _ProgramRegisterFormStore with Store {
  // store for handling form errors
  final ProgramRegisterErrorForm formErrorStore = ProgramRegisterErrorForm();

  // store for handling error messages
  final MessageStore messageStore = MessageStore();

  // store for handling authenticators
  final CommonStore commonStore; // = getIt<CommonStore>();

  _ProgramRegisterFormStore(this.commonStore) {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => name, validateName),
      reaction((_) => email, validateName),
      reaction((_) => description, validateDescription),
      reaction((_) => note, validateNote),
      reaction((_) => expectation, validateExpectation),
      reaction((_) => goal, validateGoal),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String name = '';

  @observable
  String email = '';

  @observable
  String description = '';

  @observable
  String note = '';

  @observable
  String expectation = '';

  @observable
  String goal = '';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @computed
  bool get canRegisterProgram =>
      !formErrorStore.hasErrorsInRegister &&
      name.isNotEmpty &&
      email.isNotEmpty &&
      description.isNotEmpty &&
      note.isNotEmpty &&
      expectation.isNotEmpty &&
      goal.isNotEmpty;

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
  void setDescription(String value) {
    description = value;
  }

  @action
  void setNote(String value) {
    note = value;
  }

  @action
  void setExpectation(String value) {
    expectation = value;
  }

  @action
  void setGoal(String value) {
    goal = value;
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
  void validateDescription(String value) {
    if (value.isEmpty) {
      formErrorStore.description = "Confirm password can't be empty";
    } else {
      formErrorStore.description = null;
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

  @action
  void validateExpectation(String value) {
    if (value.isEmpty) {
      formErrorStore.expectation =
          "You should give your expectation to your mentor";
    } else {
      formErrorStore.expectation = null;
    }
  }

  @action
  void validateGoal(String value) {
    if (value.isEmpty) {
      formErrorStore.goal = "You should give your goal to your mentor";
    } else {
      formErrorStore.goal = null;
    }
  }

  @action
  Future registerProgram({
    required int mentorID,
    required int programID,
  }) async {
    loading = true;

    commonStore.registerProgramOfMentor(
      mentorID: mentorID,
      programID: programID,
      body: {
        "name": name,
        "email": email,
        "description": description,
        "note": note,
        "expectation": expectation,
        "goal": goal,
      },
    ).then((future) {
      loading = false;

      if (future != null) {
        messageStore.errorMessage = "You should to check your connection";
        success = false;
      } else {
        messageStore.successMessage =
            "You have register this program successfully";
        success = true;
      }
    }).catchError((e) {
      loading = false;
      success = false;
      messageStore.errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
          ? "Username and password doesn't match"
          : "Something went wrong, please check your internet connection and try again";
      log(e.toString());
    });
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validateName(name);
    validateEmail(email);
    validateDescription(description);
    validateNote(note);
    validateExpectation(expectation);
    validateGoal(goal);
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
  String? confirmPassword;

  @observable
  String? description;

  @observable
  String? note;

  @observable
  String? expectation;

  @observable
  String? goal;

  @computed
  bool get hasErrorsInRegister =>
      name != null ||
      email != null ||
      description != null ||
      note != null ||
      expectation != null ||
      goal != null;
}
