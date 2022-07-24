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
  Computed<bool>? _$isInittingComputed;

  @override
  bool get isInitting => (_$isInittingComputed ??=
          Computed<bool>(() => super.isInitting, name: '_ChatStore.isInitting'))
      .value;
  Computed<bool>? _$isConnectingComputed;

  @override
  bool get isConnecting =>
      (_$isConnectingComputed ??= Computed<bool>(() => super.isConnecting,
              name: '_ChatStore.isConnecting'))
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
  Computed<ObservableList<types.Message>>? _$typesMessageChatsComputed;

  @override
  ObservableList<types.Message> get typesMessageChats =>
      (_$typesMessageChatsComputed ??= Computed<ObservableList<types.Message>>(
              () => super.typesMessageChats,
              name: '_ChatStore.typesMessageChats'))
          .value;

  late final _$successInGetRoomAtom =
      Atom(name: '_ChatStore.successInGetRoom', context: context);

  @override
  bool get successInGetRoom {
    _$successInGetRoomAtom.reportRead();
    return super.successInGetRoom;
  }

  @override
  set successInGetRoom(bool value) {
    _$successInGetRoomAtom.reportWrite(value, super.successInGetRoom, () {
      super.successInGetRoom = value;
    });
  }

  late final _$successInConnectSocketAtom =
      Atom(name: '_ChatStore.successInConnectSocket', context: context);

  @override
  bool get successInConnectSocket {
    _$successInConnectSocketAtom.reportRead();
    return super.successInConnectSocket;
  }

  @override
  set successInConnectSocket(bool value) {
    _$successInConnectSocketAtom
        .reportWrite(value, super.successInConnectSocket, () {
      super.successInConnectSocket = value;
    });
  }

  late final _$successInGetMessageAtom =
      Atom(name: '_ChatStore.successInGetMessage', context: context);

  @override
  bool get successInGetMessage {
    _$successInGetMessageAtom.reportRead();
    return super.successInGetMessage;
  }

  @override
  set successInGetMessage(bool value) {
    _$successInGetMessageAtom.reportWrite(value, super.successInGetMessage, () {
      super.successInGetMessage = value;
    });
  }

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

  late final _$requestChatRoomInformationFutureAtom = Atom(
      name: '_ChatStore.requestChatRoomInformationFuture', context: context);

  @override
  ObservableFuture<Map<String, dynamic>?> get requestChatRoomInformationFuture {
    _$requestChatRoomInformationFutureAtom.reportRead();
    return super.requestChatRoomInformationFuture;
  }

  @override
  set requestChatRoomInformationFuture(
      ObservableFuture<Map<String, dynamic>?> value) {
    _$requestChatRoomInformationFutureAtom
        .reportWrite(value, super.requestChatRoomInformationFuture, () {
      super.requestChatRoomInformationFuture = value;
    });
  }

  late final _$connectFutureAtom =
      Atom(name: '_ChatStore.connectFuture', context: context);

  @override
  FutureStatus get connectFuture {
    _$connectFutureAtom.reportRead();
    return super.connectFuture;
  }

  @override
  set connectFuture(FutureStatus value) {
    _$connectFutureAtom.reportWrite(value, super.connectFuture, () {
      super.connectFuture = value;
    });
  }

  late final _$chatsAtom = Atom(name: '_ChatStore.chats', context: context);

  @override
  ObservableList<types.TextMessage> get chats {
    _$chatsAtom.reportRead();
    return super.chats;
  }

  @override
  set chats(ObservableList<types.TextMessage> value) {
    _$chatsAtom.reportWrite(value, super.chats, () {
      super.chats = value;
    });
  }

  late final _$connectSocketAsyncAction =
      AsyncAction('_ChatStore.connectSocket', context: context);

  @override
  Future<dynamic> connectSocket() {
    return _$connectSocketAsyncAction.run(() => super.connectSocket());
  }

  late final _$getChatRoomInformationAsyncAction =
      AsyncAction('_ChatStore.getChatRoomInformation', context: context);

  @override
  Future<types.User?> getChatRoomInformation() {
    return _$getChatRoomInformationAsyncAction
        .run(() => super.getChatRoomInformation());
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
  Future<bool> getRoomInformation({required int roomId}) {
    return _$getRoomInformationAsyncAction
        .run(() => super.getRoomInformation(roomId: roomId));
  }

  late final _$sendMessageAsyncAction =
      AsyncAction('_ChatStore.sendMessage', context: context);

  @override
  Future<void> sendMessage({required types.TextMessage message}) {
    return _$sendMessageAsyncAction
        .run(() => super.sendMessage(message: message));
  }

  late final _$fetchAllMessagesAsyncAction =
      AsyncAction('_ChatStore.fetchAllMessages', context: context);

  @override
  Future<void> fetchAllMessages(
      [Map<String, int> params = const {"limit": 40, "skip": 0}]) {
    return _$fetchAllMessagesAsyncAction
        .run(() => super.fetchAllMessages(params));
  }

  late final _$_ChatStoreActionController =
      ActionController(name: '_ChatStore', context: context);

  @override
  void addNewMessageFromSocket(dynamic data) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.addNewMessageFromSocket');
    try {
      return super.addNewMessageFromSocket(data);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pushFontToChats(ChatMessage element) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.pushFontToChats');
    try {
      return super.pushFontToChats(element);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pushBackToChats(ChatMessage element) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.pushBackToChats');
    try {
      return super.pushBackToChats(element);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
successInGetRoom: ${successInGetRoom},
successInConnectSocket: ${successInConnectSocket},
successInGetMessage: ${successInGetMessage},
success: ${success},
requestFuture: ${requestFuture},
requestChatRoomInformationFuture: ${requestChatRoomInformationFuture},
connectFuture: ${connectFuture},
chats: ${chats},
isLoading: ${isLoading},
isInitting: ${isInitting},
isConnecting: ${isConnecting},
getSuccessMessageKey: ${getSuccessMessageKey},
getFailedMessageKey: ${getFailedMessageKey},
typesMessageChats: ${typesMessageChats}
    ''';
  }
}
