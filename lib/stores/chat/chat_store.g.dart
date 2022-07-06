// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatStore on _ChatStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_ChatStore.isLoading'))
      .value;
  Computed<String>? _$getSuccessMessageKeyComputed;

  @override
  String get getSuccessMessageKey => (_$getSuccessMessageKeyComputed ??=
          Computed<String>(() => super.getSuccessMessageKey,
              name: '_ChatStore.getSuccessMessageKey'))
      .value;
  Computed<String>? _$getFailedMessageKeyComputed;

  @override
  String get getFailedMessageKey => (_$getFailedMessageKeyComputed ??=
          Computed<String>(() => super.getFailedMessageKey,
              name: '_ChatStore.getFailedMessageKey'))
      .value;

  late final _$successAtom = Atom(name: '_ChatStore.success', context: context);

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
      Atom(name: '_ChatStore.requestFuture', context: context);

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

  late final _$getChatRoomInformationAsyncAction =
      AsyncAction('_ChatStore.getChatRoomInformation', context: context);

  @override
  Future<void> getChatRoomInformation(int sessionId) {
    return _$getChatRoomInformationAsyncAction
        .run(() => super.getChatRoomInformation(sessionId));
  }

  late final _$getAllRoomsAsyncAction =
      AsyncAction('_ChatStore.getAllRooms', context: context);

  @override
  Future<void> getAllRooms() {
    return _$getAllRoomsAsyncAction.run(() => super.getAllRooms());
  }

  late final _$getRoomInformationAsyncAction =
      AsyncAction('_ChatStore.getRoomInformation', context: context);

  @override
  Future<void> getRoomInformation({required int roomId}) {
    return _$getRoomInformationAsyncAction
        .run(() => super.getRoomInformation(roomId: roomId));
  }

  late final _$sendMessageAsyncAction =
      AsyncAction('_ChatStore.sendMessage', context: context);

  @override
  Future<void> sendMessage({required int roomId, required String message}) {
    return _$sendMessageAsyncAction
        .run(() => super.sendMessage(roomId: roomId, message: message));
  }

  late final _$fetchAllMessagesAsyncAction =
      AsyncAction('_ChatStore.fetchAllMessages', context: context);

  @override
  Future<void> fetchAllMessages(int roomId,
      [Map<String, int> params = const {"limit": 20, "skip": 0}]) {
    return _$fetchAllMessagesAsyncAction
        .run(() => super.fetchAllMessages(roomId, params));
  }

  @override
  String toString() {
    return '''
success: ${success},
requestFuture: ${requestFuture},
isLoading: ${isLoading},
getSuccessMessageKey: ${getSuccessMessageKey},
getFailedMessageKey: ${getFailedMessageKey}
    ''';
  }
}
