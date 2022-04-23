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

  final _$successAtom = Atom(name: '_MentorStore.success');

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

  final _$pageAtom = Atom(name: '_MentorStore.page');

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

  final _$requestFutureAtom = Atom(name: '_MentorStore.requestFuture');

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

  final _$listMentorsAtom = Atom(name: '_MentorStore.listMentors');

  @override
  List<MentorModel> get listMentors {
    _$listMentorsAtom.reportRead();
    return super.listMentors;
  }

  @override
  set listMentors(List<MentorModel> value) {
    _$listMentorsAtom.reportWrite(value, super.listMentors, () {
      super.listMentors = value;
    });
  }

  final _$searchMentorsAsyncAction = AsyncAction('_MentorStore.searchMentors');

  @override
  Future<void> searchMentors() {
    return _$searchMentorsAsyncAction.run(() => super.searchMentors());
  }

  final _$_MentorStoreActionController = ActionController(name: '_MentorStore');

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
  String toString() {
    return '''
success: ${success},
page: ${page},
requestFuture: ${requestFuture},
listMentors: ${listMentors},
isLoading: ${isLoading}
    ''';
  }
}
