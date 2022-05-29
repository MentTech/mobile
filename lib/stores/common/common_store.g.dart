// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CommonStore on _CommonStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_CommonStore.isLoading'))
      .value;
  Computed<dynamic>? _$programLengthListComputed;

  @override
  dynamic get programLengthList => (_$programLengthListComputed ??=
          Computed<dynamic>(() => super.programLengthList,
              name: '_CommonStore.programLengthList'))
      .value;

  late final _$successAtom =
      Atom(name: '_CommonStore.success', context: context);

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

  late final _$requestFutureAtom =
      Atom(name: '_CommonStore.requestFuture', context: context);

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

  late final _$rateModelsAtom =
      Atom(name: '_CommonStore.rateModels', context: context);

  @override
  ObservableList<RateModel> get rateModels {
    _$rateModelsAtom.reportRead();
    return super.rateModels;
  }

  @override
  set rateModels(ObservableList<RateModel> value) {
    _$rateModelsAtom.reportWrite(value, super.rateModels, () {
      super.rateModels = value;
    });
  }

  late final _$fetchProgramRateListAsyncAction =
      AsyncAction('_CommonStore.fetchProgramRateList', context: context);

  @override
  Future<void> fetchProgramRateList(int mentorID, int programID) {
    return _$fetchProgramRateListAsyncAction
        .run(() => super.fetchProgramRateList(mentorID, programID));
  }

  late final _$registerProgramOfMentorAsyncAction =
      AsyncAction('_CommonStore.registerProgramOfMentor', context: context);

  @override
  Future<bool?> registerProgramOfMentor(
      {required int mentorID,
      required int programID,
      required Map<String, String> body}) {
    return _$registerProgramOfMentorAsyncAction.run(() => super
        .registerProgramOfMentor(
            mentorID: mentorID, programID: programID, body: body));
  }

  late final _$_CommonStoreActionController =
      ActionController(name: '_CommonStore', context: context);

  @override
  bool nextProgramRatePage() {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.nextProgramRatePage');
    try {
      return super.nextProgramRatePage();
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool prevProgramRatePage() {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.prevProgramRatePage');
    try {
      return super.prevProgramRatePage();
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
success: ${success},
requestFuture: ${requestFuture},
rateModels: ${rateModels},
isLoading: ${isLoading},
programLengthList: ${programLengthList}
    ''';
  }
}
