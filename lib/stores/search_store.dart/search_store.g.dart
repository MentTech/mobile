// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchStore on _SearchStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_SearchStore.isLoading'))
      .value;
  Computed<List<Category>>? _$categoryListComputed;

  @override
  List<Category> get categoryList => (_$categoryListComputed ??=
          Computed<List<Category>>(() => super.categoryList,
              name: '_SearchStore.categoryList'))
      .value;
  Computed<List<Skill>>? _$skillListComputed;

  @override
  List<Skill> get skillList =>
      (_$skillListComputed ??= Computed<List<Skill>>(() => super.skillList,
              name: '_SearchStore.skillList'))
          .value;
  Computed<Category?>? _$selectedCategoryComputed;

  @override
  Category? get selectedCategory => (_$selectedCategoryComputed ??=
          Computed<Category?>(() => super.selectedCategory,
              name: '_SearchStore.selectedCategory'))
      .value;
  Computed<List<Skill>>? _$selectedSkillListComputed;

  @override
  List<Skill> get selectedSkillList => (_$selectedSkillListComputed ??=
          Computed<List<Skill>>(() => super.selectedSkillList,
              name: '_SearchStore.selectedSkillList'))
      .value;
  Computed<OrderType>? _$sortTypeComputed;

  @override
  OrderType get sortType =>
      (_$sortTypeComputed ??= Computed<OrderType>(() => super.sortType,
              name: '_SearchStore.sortType'))
          .value;
  Computed<OrderByType>? _$orderByComputed;

  @override
  OrderByType get orderBy =>
      (_$orderByComputed ??= Computed<OrderByType>(() => super.orderBy,
              name: '_SearchStore.orderBy'))
          .value;

  late final _$successAtom =
      Atom(name: '_SearchStore.success', context: context);

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

  late final _$searchKeyAtom =
      Atom(name: '_SearchStore.searchKey', context: context);

  @override
  String get searchKey {
    _$searchKeyAtom.reportRead();
    return super.searchKey;
  }

  @override
  set searchKey(String value) {
    _$searchKeyAtom.reportWrite(value, super.searchKey, () {
      super.searchKey = value;
    });
  }

  late final _$orderTypeAtom =
      Atom(name: '_SearchStore.orderType', context: context);

  @override
  OrderType get orderType {
    _$orderTypeAtom.reportRead();
    return super.orderType;
  }

  @override
  set orderType(OrderType value) {
    _$orderTypeAtom.reportWrite(value, super.orderType, () {
      super.orderType = value;
    });
  }

  late final _$orderByTypeAtom =
      Atom(name: '_SearchStore.orderByType', context: context);

  @override
  OrderByType get orderByType {
    _$orderByTypeAtom.reportRead();
    return super.orderByType;
  }

  @override
  set orderByType(OrderByType value) {
    _$orderByTypeAtom.reportWrite(value, super.orderByType, () {
      super.orderByType = value;
    });
  }

  late final _$categoryAtom =
      Atom(name: '_SearchStore.category', context: context);

  @override
  Category? get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(Category? value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  late final _$selectedSkillsAtom =
      Atom(name: '_SearchStore.selectedSkills', context: context);

  @override
  ObservableList<Skill> get selectedSkills {
    _$selectedSkillsAtom.reportRead();
    return super.selectedSkills;
  }

  @override
  set selectedSkills(ObservableList<Skill> value) {
    _$selectedSkillsAtom.reportWrite(value, super.selectedSkills, () {
      super.selectedSkills = value;
    });
  }

  late final _$requestCategoriesFutureAtom =
      Atom(name: '_SearchStore.requestCategoriesFuture', context: context);

  @override
  ObservableFuture<Map<String, dynamic>?> get requestCategoriesFuture {
    _$requestCategoriesFutureAtom.reportRead();
    return super.requestCategoriesFuture;
  }

  @override
  set requestCategoriesFuture(ObservableFuture<Map<String, dynamic>?> value) {
    _$requestCategoriesFutureAtom
        .reportWrite(value, super.requestCategoriesFuture, () {
      super.requestCategoriesFuture = value;
    });
  }

  late final _$requestSkillsFutureAtom =
      Atom(name: '_SearchStore.requestSkillsFuture', context: context);

  @override
  ObservableFuture<Map<String, dynamic>?> get requestSkillsFuture {
    _$requestSkillsFutureAtom.reportRead();
    return super.requestSkillsFuture;
  }

  @override
  set requestSkillsFuture(ObservableFuture<Map<String, dynamic>?> value) {
    _$requestSkillsFutureAtom.reportWrite(value, super.requestSkillsFuture, () {
      super.requestSkillsFuture = value;
    });
  }

  late final _$listMentorsAtom =
      Atom(name: '_SearchStore.listMentors', context: context);

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

  late final _$_SearchStoreActionController =
      ActionController(name: '_SearchStore', context: context);

  @override
  void onChangeSearchKey(String keyword) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.onChangeSearchKey');
    try {
      return super.onChangeSearchKey(keyword);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedCategory(int id) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.changeSelectedCategory');
    try {
      return super.changeSelectedCategory(id);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSelectedSkillList(List<Skill> skills) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.updateSelectedSkillList');
    try {
      return super.updateSelectedSkillList(skills);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSelectedSkills(int id) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.updateSelectedSkills');
    try {
      return super.updateSelectedSkills(id);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOrder(OrderType orderType) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.setOrder');
    try {
      return super.setOrder(orderType);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOrderBy(OrderByType orderByType) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.setOrderBy');
    try {
      return super.setOrderBy(orderByType);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
success: ${success},
searchKey: ${searchKey},
orderType: ${orderType},
orderByType: ${orderByType},
category: ${category},
selectedSkills: ${selectedSkills},
requestCategoriesFuture: ${requestCategoriesFuture},
requestSkillsFuture: ${requestSkillsFuture},
listMentors: ${listMentors},
isLoading: ${isLoading},
categoryList: ${categoryList},
skillList: ${skillList},
selectedCategory: ${selectedCategory},
selectedSkillList: ${selectedSkillList},
sortType: ${sortType},
orderBy: ${orderBy}
    ''';
  }
}
