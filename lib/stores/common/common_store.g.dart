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
  Computed<int>? _$programLengthListComputed;

  @override
  int get programLengthList => (_$programLengthListComputed ??= Computed<int>(
          () => super.programLengthList,
          name: '_CommonStore.programLengthList'))
      .value;
  Computed<Session?>? _$sessionObserverComputed;

  @override
  Session? get sessionObserver => (_$sessionObserverComputed ??=
          Computed<Session?>(() => super.sessionObserver,
              name: '_CommonStore.sessionObserver'))
      .value;
  Computed<List<Skill>>? _$fetchedSkillsComputed;

  @override
  List<Skill> get fetchedSkills => (_$fetchedSkillsComputed ??=
          Computed<List<Skill>>(() => super.fetchedSkills,
              name: '_CommonStore.fetchedSkills'))
      .value;
  Computed<List<Category>>? _$fetchedCategoriesComputed;

  @override
  List<Category> get fetchedCategories => (_$fetchedCategoriesComputed ??=
          Computed<List<Category>>(() => super.fetchedCategories,
              name: '_CommonStore.fetchedCategories'))
      .value;
  Computed<List<Skill>>? _$selectedSkillsComputed;

  @override
  List<Skill> get selectedSkills => (_$selectedSkillsComputed ??=
          Computed<List<Skill>>(() => super.selectedSkills,
              name: '_CommonStore.selectedSkills'))
      .value;
  Computed<Category?>? _$selectedCategoryComputed;

  @override
  Category? get selectedCategory => (_$selectedCategoryComputed ??=
          Computed<Category?>(() => super.selectedCategory,
              name: '_CommonStore.selectedCategory'))
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

  late final _$sessionAtom =
      Atom(name: '_CommonStore.session', context: context);

  @override
  Session? get session {
    _$sessionAtom.reportRead();
    return super.session;
  }

  @override
  set session(Session? value) {
    _$sessionAtom.reportWrite(value, super.session, () {
      super.session = value;
    });
  }

  late final _$searchingFilterModuleAtom =
      Atom(name: '_CommonStore.searchingFilterModule', context: context);

  @override
  SearchingFilterModule get searchingFilterModule {
    _$searchingFilterModuleAtom.reportRead();
    return super.searchingFilterModule;
  }

  @override
  set searchingFilterModule(SearchingFilterModule value) {
    _$searchingFilterModuleAtom.reportWrite(value, super.searchingFilterModule,
        () {
      super.searchingFilterModule = value;
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

  late final _$unregisterSessionOfProgramAsyncAction =
      AsyncAction('_CommonStore.unregisterSessionOfProgram', context: context);

  @override
  Future<void> unregisterSessionOfProgram({VoidCallback? callback}) {
    return _$unregisterSessionOfProgramAsyncAction
        .run(() => super.unregisterSessionOfProgram(callback: callback));
  }

  late final _$markSessionOfProgramAsDoneAsyncAction =
      AsyncAction('_CommonStore.markSessionOfProgramAsDone', context: context);

  @override
  Future<void> markSessionOfProgramAsDone() {
    return _$markSessionOfProgramAsDoneAsyncAction
        .run(() => super.markSessionOfProgramAsDone());
  }

  late final _$reviewSessionOfProgramAsyncAction =
      AsyncAction('_CommonStore.reviewSessionOfProgram', context: context);

  @override
  Future<void> reviewSessionOfProgram(ReviewModel reviewModel) {
    return _$reviewSessionOfProgramAsyncAction
        .run(() => super.reviewSessionOfProgram(reviewModel));
  }

  late final _$fetchAllSkillsAsyncAction =
      AsyncAction('_CommonStore.fetchAllSkills', context: context);

  @override
  Future<void> fetchAllSkills() {
    return _$fetchAllSkillsAsyncAction.run(() => super.fetchAllSkills());
  }

  late final _$fetchAllCategoriesAsyncAction =
      AsyncAction('_CommonStore.fetchAllCategories', context: context);

  @override
  Future<void> fetchAllCategories() {
    return _$fetchAllCategoriesAsyncAction
        .run(() => super.fetchAllCategories());
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
  void setSessionObserver(Session session) {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.setSessionObserver');
    try {
      return super.setSessionObserver(session);
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
session: ${session},
searchingFilterModule: ${searchingFilterModule},
isLoading: ${isLoading},
programLengthList: ${programLengthList},
sessionObserver: ${sessionObserver},
fetchedSkills: ${fetchedSkills},
fetchedCategories: ${fetchedCategories},
selectedSkills: ${selectedSkills},
selectedCategory: ${selectedCategory}
    ''';
  }
}
