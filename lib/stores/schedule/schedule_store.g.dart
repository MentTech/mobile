// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ScheduleStore on _ScheduleStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_ScheduleStore.isLoading'))
          .value;
  Computed<bool>? _$isCalendarLoadingComputed;

  @override
  bool get isCalendarLoading => (_$isCalendarLoadingComputed ??= Computed<bool>(
          () => super.isCalendarLoading,
          name: '_ScheduleStore.isCalendarLoading'))
      .value;
  Computed<bool>? _$isListLoadingComputed;

  @override
  bool get isListLoading =>
      (_$isListLoadingComputed ??= Computed<bool>(() => super.isListLoading,
              name: '_ScheduleStore.isListLoading'))
          .value;
  Computed<int>? _$sizeCalendarSessionsComputed;

  @override
  int get sizeCalendarSessions => (_$sizeCalendarSessionsComputed ??=
          Computed<int>(() => super.sizeCalendarSessions,
              name: '_ScheduleStore.sizeCalendarSessions'))
      .value;
  Computed<List<Session>>? _$listCalendarSessionsComputed;

  @override
  List<Session> get listCalendarSessions => (_$listCalendarSessionsComputed ??=
          Computed<List<Session>>(() => super.listCalendarSessions,
              name: '_ScheduleStore.listCalendarSessions'))
      .value;
  Computed<int>? _$sizeListSessionComputed;

  @override
  int get sizeListSession =>
      (_$sizeListSessionComputed ??= Computed<int>(() => super.sizeListSession,
              name: '_ScheduleStore.sizeListSession'))
          .value;
  Computed<List<Session>>? _$listListSessionsComputed;

  @override
  List<Session> get listListSessions => (_$listListSessionsComputed ??=
          Computed<List<Session>>(() => super.listListSessions,
              name: '_ScheduleStore.listListSessions'))
      .value;
  Computed<String>? _$getSuccessMessageKeyComputed;

  @override
  String get getSuccessMessageKey => (_$getSuccessMessageKeyComputed ??=
          Computed<String>(() => super.getSuccessMessageKey,
              name: '_ScheduleStore.getSuccessMessageKey'))
      .value;
  Computed<String>? _$getFailedMessageKeyComputed;

  @override
  String get getFailedMessageKey => (_$getFailedMessageKeyComputed ??=
          Computed<String>(() => super.getFailedMessageKey,
              name: '_ScheduleStore.getFailedMessageKey'))
      .value;

  late final _$successAtom =
      Atom(name: '_ScheduleStore.success', context: context);

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

  late final _$triggerChangeAtom =
      Atom(name: '_ScheduleStore.triggerChange', context: context);

  @override
  bool get triggerChange {
    _$triggerChangeAtom.reportRead();
    return super.triggerChange;
  }

  @override
  set triggerChange(bool value) {
    _$triggerChangeAtom.reportWrite(value, super.triggerChange, () {
      super.triggerChange = value;
    });
  }

  late final _$requestNormalFutureAtom =
      Atom(name: '_ScheduleStore.requestNormalFuture', context: context);

  @override
  ObservableFuture<Map<String, dynamic>?> get requestNormalFuture {
    _$requestNormalFutureAtom.reportRead();
    return super.requestNormalFuture;
  }

  @override
  set requestNormalFuture(ObservableFuture<Map<String, dynamic>?> value) {
    _$requestNormalFutureAtom.reportWrite(value, super.requestNormalFuture, () {
      super.requestNormalFuture = value;
    });
  }

  late final _$requestCalendarFutureAtom =
      Atom(name: '_ScheduleStore.requestCalendarFuture', context: context);

  @override
  ObservableFuture<Map<String, dynamic>?> get requestCalendarFuture {
    _$requestCalendarFutureAtom.reportRead();
    return super.requestCalendarFuture;
  }

  @override
  set requestCalendarFuture(ObservableFuture<Map<String, dynamic>?> value) {
    _$requestCalendarFutureAtom.reportWrite(value, super.requestCalendarFuture,
        () {
      super.requestCalendarFuture = value;
    });
  }

  late final _$requestListFutureAtom =
      Atom(name: '_ScheduleStore.requestListFuture', context: context);

  @override
  ObservableFuture<Map<String, dynamic>?> get requestListFuture {
    _$requestListFutureAtom.reportRead();
    return super.requestListFuture;
  }

  @override
  set requestListFuture(ObservableFuture<Map<String, dynamic>?> value) {
    _$requestListFutureAtom.reportWrite(value, super.requestListFuture, () {
      super.requestListFuture = value;
    });
  }

  late final _$sessionsByCalendarAtom =
      Atom(name: '_ScheduleStore.sessionsByCalendar', context: context);

  @override
  ObservableList<Session> get sessionsByCalendar {
    _$sessionsByCalendarAtom.reportRead();
    return super.sessionsByCalendar;
  }

  @override
  set sessionsByCalendar(ObservableList<Session> value) {
    _$sessionsByCalendarAtom.reportWrite(value, super.sessionsByCalendar, () {
      super.sessionsByCalendar = value;
    });
  }

  late final _$sessionsByGroupListAtom =
      Atom(name: '_ScheduleStore.sessionsByGroupList', context: context);

  @override
  ObservableList<Session> get sessionsByGroupList {
    _$sessionsByGroupListAtom.reportRead();
    return super.sessionsByGroupList;
  }

  @override
  set sessionsByGroupList(ObservableList<Session> value) {
    _$sessionsByGroupListAtom.reportWrite(value, super.sessionsByGroupList, () {
      super.sessionsByGroupList = value;
    });
  }

  late final _$fetchAllSessionsByListAsyncAction =
      AsyncAction('_ScheduleStore.fetchAllSessionsByList', context: context);

  @override
  Future<void> fetchAllSessionsByList() {
    return _$fetchAllSessionsByListAsyncAction
        .run(() => super.fetchAllSessionsByList());
  }

  late final _$fetchSessionsByDateAsyncAction =
      AsyncAction('_ScheduleStore.fetchSessionsByDate', context: context);

  @override
  Future<void> fetchSessionsByDate({required DateTime date}) {
    return _$fetchSessionsByDateAsyncAction
        .run(() => super.fetchSessionsByDate(date: date));
  }

  late final _$fetchSessionByIDAsyncAction =
      AsyncAction('_ScheduleStore.fetchSessionByID', context: context);

  @override
  Future<Session?> fetchSessionByID({required int sessionId}) {
    return _$fetchSessionByIDAsyncAction
        .run(() => super.fetchSessionByID(sessionId: sessionId));
  }

  @override
  String toString() {
    return '''
success: ${success},
triggerChange: ${triggerChange},
requestNormalFuture: ${requestNormalFuture},
requestCalendarFuture: ${requestCalendarFuture},
requestListFuture: ${requestListFuture},
sessionsByCalendar: ${sessionsByCalendar},
sessionsByGroupList: ${sessionsByGroupList},
isLoading: ${isLoading},
isCalendarLoading: ${isCalendarLoading},
isListLoading: ${isListLoading},
sizeCalendarSessions: ${sizeCalendarSessions},
listCalendarSessions: ${listCalendarSessions},
sizeListSession: ${sizeListSession},
listListSessions: ${listListSessions},
getSuccessMessageKey: ${getSuccessMessageKey},
getFailedMessageKey: ${getFailedMessageKey}
    ''';
  }
}
