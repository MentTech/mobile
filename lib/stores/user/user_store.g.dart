// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_UserStore.isLoading'))
      .value;
  Computed<int>? _$sizeSessionListComputed;

  @override
  int get sizeSessionList =>
      (_$sizeSessionListComputed ??= Computed<int>(() => super.sizeSessionList,
              name: '_UserStore.sizeSessionList'))
          .value;

  late final _$successAtom = Atom(name: '_UserStore.success', context: context);

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
      Atom(name: '_UserStore.requestFuture', context: context);

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

  late final _$userAtom = Atom(name: '_UserStore.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$sessionStatusAtom =
      Atom(name: '_UserStore.sessionStatus', context: context);

  @override
  SessionStatus get sessionStatus {
    _$sessionStatusAtom.reportRead();
    return super.sessionStatus;
  }

  @override
  set sessionStatus(SessionStatus value) {
    _$sessionStatusAtom.reportWrite(value, super.sessionStatus, () {
      super.sessionStatus = value;
    });
  }

  late final _$sessionFetchingDataAtom =
      Atom(name: '_UserStore.sessionFetchingData', context: context);

  @override
  SessionFetchingData get sessionFetchingData {
    _$sessionFetchingDataAtom.reportRead();
    return super.sessionFetchingData;
  }

  @override
  set sessionFetchingData(SessionFetchingData value) {
    _$sessionFetchingDataAtom.reportWrite(value, super.sessionFetchingData, () {
      super.sessionFetchingData = value;
    });
  }

  late final _$sessionsAtom =
      Atom(name: '_UserStore.sessions', context: context);

  @override
  ObservableList<Session> get sessions {
    _$sessionsAtom.reportRead();
    return super.sessions;
  }

  @override
  set sessions(ObservableList<Session> value) {
    _$sessionsAtom.reportWrite(value, super.sessions, () {
      super.sessions = value;
    });
  }

  late final _$fetchUserInforAsyncAction =
      AsyncAction('_UserStore.fetchUserInfor', context: context);

  @override
  Future<bool> fetchUserInfor() {
    return _$fetchUserInforAsyncAction.run(() => super.fetchUserInfor());
  }

  late final _$fetchFavouriteMentorsAsyncAction =
      AsyncAction('_UserStore.fetchFavouriteMentors', context: context);

  @override
  Future<void> fetchFavouriteMentors() {
    return _$fetchFavouriteMentorsAsyncAction
        .run(() => super.fetchFavouriteMentors());
  }

  late final _$fetchUserSessionsAsyncAction =
      AsyncAction('_UserStore.fetchUserSessions', context: context);

  @override
  Future<bool> fetchUserSessions() {
    return _$fetchUserSessionsAsyncAction.run(() => super.fetchUserSessions());
  }

  late final _$_UserStoreActionController =
      ActionController(name: '_UserStore', context: context);

  @override
  void updateSessionStatus(SessionStatus sessionStatus) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.updateSessionStatus');
    try {
      return super.updateSessionStatus(sessionStatus);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
success: ${success},
requestFuture: ${requestFuture},
user: ${user},
sessionStatus: ${sessionStatus},
sessionFetchingData: ${sessionFetchingData},
sessions: ${sessions},
isLoading: ${isLoading},
sizeSessionList: ${sizeSessionList}
    ''';
  }
}
