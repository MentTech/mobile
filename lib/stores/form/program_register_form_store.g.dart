// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_register_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProgramRegisterFormStore on _ProgramRegisterFormStore, Store {
  Computed<bool>? _$canRegisterProgramComputed;

  @override
  bool get canRegisterProgram => (_$canRegisterProgramComputed ??=
          Computed<bool>(() => super.canRegisterProgram,
              name: '_ProgramRegisterFormStore.canRegisterProgram'))
      .value;

  late final _$nameAtom =
      Atom(name: '_ProgramRegisterFormStore.name', context: context);

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

  late final _$emailAtom =
      Atom(name: '_ProgramRegisterFormStore.email', context: context);

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

  late final _$descriptionAtom =
      Atom(name: '_ProgramRegisterFormStore.description', context: context);

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$noteAtom =
      Atom(name: '_ProgramRegisterFormStore.note', context: context);

  @override
  String get note {
    _$noteAtom.reportRead();
    return super.note;
  }

  @override
  set note(String value) {
    _$noteAtom.reportWrite(value, super.note, () {
      super.note = value;
    });
  }

  late final _$expectationAtom =
      Atom(name: '_ProgramRegisterFormStore.expectation', context: context);

  @override
  String get expectation {
    _$expectationAtom.reportRead();
    return super.expectation;
  }

  @override
  set expectation(String value) {
    _$expectationAtom.reportWrite(value, super.expectation, () {
      super.expectation = value;
    });
  }

  late final _$goalAtom =
      Atom(name: '_ProgramRegisterFormStore.goal', context: context);

  @override
  String get goal {
    _$goalAtom.reportRead();
    return super.goal;
  }

  @override
  set goal(String value) {
    _$goalAtom.reportWrite(value, super.goal, () {
      super.goal = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_ProgramRegisterFormStore.success', context: context);

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
      Atom(name: '_ProgramRegisterFormStore.loading', context: context);

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

  late final _$registerProgramAsyncAction = AsyncAction(
      '_ProgramRegisterFormStore.registerProgram',
      context: context);

  @override
  Future<dynamic> registerProgram(
      {required int mentorID, required int programID}) {
    return _$registerProgramAsyncAction.run(
        () => super.registerProgram(mentorID: mentorID, programID: programID));
  }

  late final _$_ProgramRegisterFormStoreActionController =
      ActionController(name: '_ProgramRegisterFormStore', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_ProgramRegisterFormStoreActionController
        .startAction(name: '_ProgramRegisterFormStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_ProgramRegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_ProgramRegisterFormStoreActionController
        .startAction(name: '_ProgramRegisterFormStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_ProgramRegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String value) {
    final _$actionInfo = _$_ProgramRegisterFormStoreActionController
        .startAction(name: '_ProgramRegisterFormStore.setDescription');
    try {
      return super.setDescription(value);
    } finally {
      _$_ProgramRegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNote(String value) {
    final _$actionInfo = _$_ProgramRegisterFormStoreActionController
        .startAction(name: '_ProgramRegisterFormStore.setNote');
    try {
      return super.setNote(value);
    } finally {
      _$_ProgramRegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExpectation(String value) {
    final _$actionInfo = _$_ProgramRegisterFormStoreActionController
        .startAction(name: '_ProgramRegisterFormStore.setExpectation');
    try {
      return super.setExpectation(value);
    } finally {
      _$_ProgramRegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGoal(String value) {
    final _$actionInfo = _$_ProgramRegisterFormStoreActionController
        .startAction(name: '_ProgramRegisterFormStore.setGoal');
    try {
      return super.setGoal(value);
    } finally {
      _$_ProgramRegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateName(String value) {
    final _$actionInfo = _$_ProgramRegisterFormStoreActionController
        .startAction(name: '_ProgramRegisterFormStore.validateName');
    try {
      return super.validateName(value);
    } finally {
      _$_ProgramRegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateEmail(String value) {
    final _$actionInfo = _$_ProgramRegisterFormStoreActionController
        .startAction(name: '_ProgramRegisterFormStore.validateEmail');
    try {
      return super.validateEmail(value);
    } finally {
      _$_ProgramRegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateDescription(String value) {
    final _$actionInfo = _$_ProgramRegisterFormStoreActionController
        .startAction(name: '_ProgramRegisterFormStore.validateDescription');
    try {
      return super.validateDescription(value);
    } finally {
      _$_ProgramRegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateNote(String value) {
    final _$actionInfo = _$_ProgramRegisterFormStoreActionController
        .startAction(name: '_ProgramRegisterFormStore.validateNote');
    try {
      return super.validateNote(value);
    } finally {
      _$_ProgramRegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateExpectation(String value) {
    final _$actionInfo = _$_ProgramRegisterFormStoreActionController
        .startAction(name: '_ProgramRegisterFormStore.validateExpectation');
    try {
      return super.validateExpectation(value);
    } finally {
      _$_ProgramRegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateGoal(String value) {
    final _$actionInfo = _$_ProgramRegisterFormStoreActionController
        .startAction(name: '_ProgramRegisterFormStore.validateGoal');
    try {
      return super.validateGoal(value);
    } finally {
      _$_ProgramRegisterFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
description: ${description},
note: ${note},
expectation: ${expectation},
goal: ${goal},
success: ${success},
loading: ${loading},
canRegisterProgram: ${canRegisterProgram}
    ''';
  }
}

mixin _$ProgramRegisterErrorForm on _ProgramRegisterErrorForm, Store {
  Computed<bool>? _$hasErrorsInRegisterComputed;

  @override
  bool get hasErrorsInRegister => (_$hasErrorsInRegisterComputed ??=
          Computed<bool>(() => super.hasErrorsInRegister,
              name: '_ProgramRegisterErrorForm.hasErrorsInRegister'))
      .value;

  late final _$nameAtom =
      Atom(name: '_ProgramRegisterErrorForm.name', context: context);

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

  late final _$emailAtom =
      Atom(name: '_ProgramRegisterErrorForm.email', context: context);

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

  late final _$confirmPasswordAtom =
      Atom(name: '_ProgramRegisterErrorForm.confirmPassword', context: context);

  @override
  String? get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String? value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_ProgramRegisterErrorForm.description', context: context);

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$noteAtom =
      Atom(name: '_ProgramRegisterErrorForm.note', context: context);

  @override
  String? get note {
    _$noteAtom.reportRead();
    return super.note;
  }

  @override
  set note(String? value) {
    _$noteAtom.reportWrite(value, super.note, () {
      super.note = value;
    });
  }

  late final _$expectationAtom =
      Atom(name: '_ProgramRegisterErrorForm.expectation', context: context);

  @override
  String? get expectation {
    _$expectationAtom.reportRead();
    return super.expectation;
  }

  @override
  set expectation(String? value) {
    _$expectationAtom.reportWrite(value, super.expectation, () {
      super.expectation = value;
    });
  }

  late final _$goalAtom =
      Atom(name: '_ProgramRegisterErrorForm.goal', context: context);

  @override
  String? get goal {
    _$goalAtom.reportRead();
    return super.goal;
  }

  @override
  set goal(String? value) {
    _$goalAtom.reportWrite(value, super.goal, () {
      super.goal = value;
    });
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
confirmPassword: ${confirmPassword},
description: ${description},
note: ${note},
expectation: ${expectation},
goal: ${goal},
hasErrorsInRegister: ${hasErrorsInRegister}
    ''';
  }
}
