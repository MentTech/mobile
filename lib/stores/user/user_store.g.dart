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
  Computed<bool>? _$isUploadingAvatarComputed;

  @override
  bool get isUploadingAvatar => (_$isUploadingAvatarComputed ??= Computed<bool>(
          () => super.isUploadingAvatar,
          name: '_UserStore.isUploadingAvatar'))
      .value;
  Computed<bool>? _$isPushingFavMentorDataComputed;

  @override
  bool get isPushingFavMentorData => (_$isPushingFavMentorDataComputed ??=
          Computed<bool>(() => super.isPushingFavMentorData,
              name: '_UserStore.isPushingFavMentorData'))
      .value;
  Computed<bool>? _$isSessionLoadingComputed;

  @override
  bool get isSessionLoading => (_$isSessionLoadingComputed ??= Computed<bool>(
          () => super.isSessionLoading,
          name: '_UserStore.isSessionLoading'))
      .value;
  Computed<bool>? _$isTransactionLoadingComputed;

  @override
  bool get isTransactionLoading => (_$isTransactionLoadingComputed ??=
          Computed<bool>(() => super.isTransactionLoading,
              name: '_UserStore.isTransactionLoading'))
      .value;
  Computed<Session?>? _$getSessionComputed;

  @override
  Session? get getSession =>
      (_$getSessionComputed ??= Computed<Session?>(() => super.getSession,
              name: '_UserStore.getSession'))
          .value;
  Computed<bool>? _$hasSessionComputed;

  @override
  bool get hasSession => (_$hasSessionComputed ??=
          Computed<bool>(() => super.hasSession, name: '_UserStore.hasSession'))
      .value;
  Computed<int>? _$sizeSessionListComputed;

  @override
  int get sizeSessionList =>
      (_$sizeSessionListComputed ??= Computed<int>(() => super.sizeSessionList,
              name: '_UserStore.sizeSessionList'))
          .value;
  Computed<int>? _$sizeNextSessionListComputed;

  @override
  int get sizeNextSessionList => (_$sizeNextSessionListComputed ??=
          Computed<int>(() => super.sizeNextSessionList,
              name: '_UserStore.sizeNextSessionList'))
      .value;
  Computed<int>? _$sizeTransactionListComputed;

  @override
  int get sizeTransactionList => (_$sizeTransactionListComputed ??=
          Computed<int>(() => super.sizeTransactionList,
              name: '_UserStore.sizeTransactionList'))
      .value;
  Computed<String>? _$getSuccessMessageKeyComputed;

  @override
  String get getSuccessMessageKey => (_$getSuccessMessageKeyComputed ??=
          Computed<String>(() => super.getSuccessMessageKey,
              name: '_UserStore.getSuccessMessageKey'))
      .value;
  Computed<String>? _$getFailedMessageKeyComputed;

  @override
  String get getFailedMessageKey => (_$getFailedMessageKeyComputed ??=
          Computed<String>(() => super.getFailedMessageKey,
              name: '_UserStore.getFailedMessageKey'))
      .value;
  Computed<SessionStatus>? _$currentSessionFetchStatusComputed;

  @override
  SessionStatus get currentSessionFetchStatus =>
      (_$currentSessionFetchStatusComputed ??= Computed<SessionStatus>(
              () => super.currentSessionFetchStatus,
              name: '_UserStore.currentSessionFetchStatus'))
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

  late final _$requestUploadAvatarFutureAtom =
      Atom(name: '_UserStore.requestUploadAvatarFuture', context: context);

  @override
  ObservableFuture<Map<String, dynamic>?> get requestUploadAvatarFuture {
    _$requestUploadAvatarFutureAtom.reportRead();
    return super.requestUploadAvatarFuture;
  }

  @override
  set requestUploadAvatarFuture(ObservableFuture<Map<String, dynamic>?> value) {
    _$requestUploadAvatarFutureAtom
        .reportWrite(value, super.requestUploadAvatarFuture, () {
      super.requestUploadAvatarFuture = value;
    });
  }

  late final _$requestFavEventFutureAtom =
      Atom(name: '_UserStore.requestFavEventFuture', context: context);

  @override
  ObservableFuture<Map<String, dynamic>?> get requestFavEventFuture {
    _$requestFavEventFutureAtom.reportRead();
    return super.requestFavEventFuture;
  }

  @override
  set requestFavEventFuture(ObservableFuture<Map<String, dynamic>?> value) {
    _$requestFavEventFutureAtom.reportWrite(value, super.requestFavEventFuture,
        () {
      super.requestFavEventFuture = value;
    });
  }

  late final _$requestSessionFutureAtom =
      Atom(name: '_UserStore.requestSessionFuture', context: context);

  @override
  ObservableFuture<Map<String, dynamic>?> get requestSessionFuture {
    _$requestSessionFutureAtom.reportRead();
    return super.requestSessionFuture;
  }

  @override
  set requestSessionFuture(ObservableFuture<Map<String, dynamic>?> value) {
    _$requestSessionFutureAtom.reportWrite(value, super.requestSessionFuture,
        () {
      super.requestSessionFuture = value;
    });
  }

  late final _$requestTransactionFutureAtom =
      Atom(name: '_UserStore.requestTransactionFuture', context: context);

  @override
  ObservableFuture<Map<String, dynamic>?> get requestTransactionFuture {
    _$requestTransactionFutureAtom.reportRead();
    return super.requestTransactionFuture;
  }

  @override
  set requestTransactionFuture(ObservableFuture<Map<String, dynamic>?> value) {
    _$requestTransactionFutureAtom
        .reportWrite(value, super.requestTransactionFuture, () {
      super.requestTransactionFuture = value;
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

  late final _$balanceAtom = Atom(name: '_UserStore.balance', context: context);

  @override
  int get balance {
    _$balanceAtom.reportRead();
    return super.balance;
  }

  @override
  set balance(int value) {
    _$balanceAtom.reportWrite(value, super.balance, () {
      super.balance = value;
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

  late final _$sessionAtom = Atom(name: '_UserStore.session', context: context);

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

  late final _$nextSessionsAtom =
      Atom(name: '_UserStore.nextSessions', context: context);

  @override
  ObservableList<Session> get nextSessions {
    _$nextSessionsAtom.reportRead();
    return super.nextSessions;
  }

  @override
  set nextSessions(ObservableList<Session> value) {
    _$nextSessionsAtom.reportWrite(value, super.nextSessions, () {
      super.nextSessions = value;
    });
  }

  late final _$_transactionContentAtom =
      Atom(name: '_UserStore._transactionContent', context: context);

  @override
  TransactionContent? get _transactionContent {
    _$_transactionContentAtom.reportRead();
    return super._transactionContent;
  }

  @override
  set _transactionContent(TransactionContent? value) {
    _$_transactionContentAtom.reportWrite(value, super._transactionContent, () {
      super._transactionContent = value;
    });
  }

  late final _$fetchUserInforAsyncAction =
      AsyncAction('_UserStore.fetchUserInfor', context: context);

  @override
  Future<bool> fetchUserInfor() {
    return _$fetchUserInforAsyncAction.run(() => super.fetchUserInfor());
  }

  late final _$fetchMyTransactionsAsyncAction =
      AsyncAction('_UserStore.fetchMyTransactions', context: context);

  @override
  Future<bool> fetchMyTransactions() {
    return _$fetchMyTransactionsAsyncAction
        .run(() => super.fetchMyTransactions());
  }

  late final _$fetchFavouriteMentorsAsyncAction =
      AsyncAction('_UserStore.fetchFavouriteMentors', context: context);

  @override
  Future<void> fetchFavouriteMentors({VoidCallback? callback}) {
    return _$fetchFavouriteMentorsAsyncAction
        .run(() => super.fetchFavouriteMentors(callback: callback));
  }

  late final _$fetchUserSessionsAsyncAction =
      AsyncAction('_UserStore.fetchUserSessions', context: context);

  @override
  Future<bool> fetchUserSessions() {
    return _$fetchUserSessionsAsyncAction.run(() => super.fetchUserSessions());
  }

  late final _$fetchNextSessionsAsyncAction =
      AsyncAction('_UserStore.fetchNextSessions', context: context);

  @override
  Future<void> fetchNextSessions() {
    return _$fetchNextSessionsAsyncAction.run(() => super.fetchNextSessions());
  }

  late final _$fetchSessionAsyncAction =
      AsyncAction('_UserStore.fetchSession', context: context);

  @override
  Future<void> fetchSession({required int sessionId}) {
    return _$fetchSessionAsyncAction
        .run(() => super.fetchSession(sessionId: sessionId));
  }

  late final _$callUpdateFavMentorAsyncAction =
      AsyncAction('_UserStore.callUpdateFavMentor', context: context);

  @override
  Future<bool> callUpdateFavMentor({required int mentorID}) {
    return _$callUpdateFavMentorAsyncAction
        .run(() => super.callUpdateFavMentor(mentorID: mentorID));
  }

  late final _$uploadUserAvatarAsyncAction =
      AsyncAction('_UserStore.uploadUserAvatar', context: context);

  @override
  Future<bool> uploadUserAvatar({required File imageFile}) {
    return _$uploadUserAvatarAsyncAction
        .run(() => super.uploadUserAvatar(imageFile: imageFile));
  }

  late final _$updateUserInformationAsyncAction =
      AsyncAction('_UserStore.updateUserInformation', context: context);

  @override
  Future<void> updateUserInformation({required Map<String, String> data}) {
    return _$updateUserInformationAsyncAction
        .run(() => super.updateUserInformation(data: data));
  }

  late final _$applyGiftcodeAsyncAction =
      AsyncAction('_UserStore.applyGiftcode', context: context);

  @override
  Future<void> applyGiftcode({required Map<String, String> data}) {
    return _$applyGiftcodeAsyncAction
        .run(() => super.applyGiftcode(data: data));
  }

  late final _$_UserStoreActionController =
      ActionController(name: '_UserStore', context: context);

  @override
  Session? getSessionAt(int index) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.getSessionAt');
    try {
      return super.getSessionAt(index);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

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
requestUploadAvatarFuture: ${requestUploadAvatarFuture},
requestFavEventFuture: ${requestFavEventFuture},
requestSessionFuture: ${requestSessionFuture},
requestTransactionFuture: ${requestTransactionFuture},
user: ${user},
balance: ${balance},
sessionStatus: ${sessionStatus},
sessionFetchingData: ${sessionFetchingData},
session: ${session},
sessions: ${sessions},
nextSessions: ${nextSessions},
isLoading: ${isLoading},
isUploadingAvatar: ${isUploadingAvatar},
isPushingFavMentorData: ${isPushingFavMentorData},
isSessionLoading: ${isSessionLoading},
isTransactionLoading: ${isTransactionLoading},
getSession: ${getSession},
hasSession: ${hasSession},
sizeSessionList: ${sizeSessionList},
sizeNextSessionList: ${sizeNextSessionList},
sizeTransactionList: ${sizeTransactionList},
getSuccessMessageKey: ${getSuccessMessageKey},
getFailedMessageKey: ${getFailedMessageKey},
currentSessionFetchStatus: ${currentSessionFetchStatus}
    ''';
  }
}
