// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MentorStore on _MentorStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_MentorStore.isLoading'))
      .value;
  Computed<MentorModel?>? _$getMentorComputed;

  @override
  MentorModel? get getMentor =>
      (_$getMentorComputed ??= Computed<MentorModel?>(() => super.getMentor,
              name: '_MentorStore.getMentor'))
          .value;
  Computed<bool>? _$hasMentorComputed;

  @override
  bool get hasMentor => (_$hasMentorComputed ??=
          Computed<bool>(() => super.hasMentor, name: '_MentorStore.hasMentor'))
      .value;

  late final _$successAtom =
      Atom(name: '_MentorStore.success', context: context);

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

  late final _$pageAtom = Atom(name: '_MentorStore.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$requestFutureAtom =
      Atom(name: '_MentorStore.requestFuture', context: context);

  @override
  ObservableFuture<Map<String, dynamic>?> get requestFuture {
    _$requestFutureAtom.reportRead();
    return super.requestFuture;
  }

  @override
  set requestFuture(ObservableFuture<Map<String, dynamic>?> value) {
    _$requestFutureAtom.reportWrite(value, super.requestFuture, () {
      super.requestFuture = value;
    });
  }

  late final _$listMentorsAtom =
      Atom(name: '_MentorStore.listMentors', context: context);

  @override
  ObservableList<MentorModel> get listMentors {
    _$listMentorsAtom.reportRead();
    return super.listMentors;
  }

  @override
  set listMentors(ObservableList<MentorModel> value) {
    _$listMentorsAtom.reportWrite(value, super.listMentors, () {
      super.listMentors = value;
    });
  }

  late final _$mentorModelAtom =
      Atom(name: '_MentorStore.mentorModel', context: context);

  @override
  MentorModel? get mentorModel {
    _$mentorModelAtom.reportRead();
    return super.mentorModel;
  }

  @override
  set mentorModel(MentorModel? value) {
    _$mentorModelAtom.reportWrite(value, super.mentorModel, () {
      super.mentorModel = value;
    });
  }

  late final _$searchMentorsAsyncAction =
      AsyncAction('_MentorStore.searchMentors', context: context);

  @override
  Future<void> searchMentors() {
    return _$searchMentorsAsyncAction.run(() => super.searchMentors());
  }

  late final _$fetchAMentorAsyncAction =
      AsyncAction('_MentorStore.fetchAMentor', context: context);

  @override
  Future<void> fetchAMentor(int mentorID) {
    return _$fetchAMentorAsyncAction.run(() => super.fetchAMentor(mentorID));
  }

  late final _$_MentorStoreActionController =
      ActionController(name: '_MentorStore', context: context);

  @override
  bool nextPage() {
    final _$actionInfo = _$_MentorStoreActionController.startAction(
        name: '_MentorStore.nextPage');
    try {
      return super.nextPage();
    } finally {
      _$_MentorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool prevPage() {
    final _$actionInfo = _$_MentorStoreActionController.startAction(
        name: '_MentorStore.prevPage');
    try {
      return super.prevPage();
    } finally {
      _$_MentorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCurrentMentor() {
    final _$actionInfo = _$_MentorStoreActionController.startAction(
        name: '_MentorStore.clearCurrentMentor');
    try {
      return super.clearCurrentMentor();
    } finally {
      _$_MentorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
success: ${success},
page: ${page},
requestFuture: ${requestFuture},
listMentors: ${listMentors},
mentorModel: ${mentorModel},
isLoading: ${isLoading},
getMentor: ${getMentor},
hasMentor: ${hasMentor}
    ''';
  }
}
