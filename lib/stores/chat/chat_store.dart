import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/data/network/constants/endpoints.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/chat/chat_room_information.dart';
import 'package:mobile/models/chat/message_chat.dart';
import 'package:mobile/models/chat/room_information.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobx/mobx.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling error messages
  final MessageStore _messageStore = getIt<MessageStore>();

  // websocket
  io.Socket socket = io.io(
    Endpoints.baseUrl,
    io.OptionBuilder().disableAutoConnect().build(),
  );

  // constructor:---------------------------------------------------------------
  _ChatStore(Repository repository) : _repository = repository {
    // setting up disposers
    _setupDisposers();

    // fetch all notifications when start app
    // fetchAllNotifications();
  }

  // connect to server by websocket
  void connectSocket() {
    // socket setup

    log("[message] [socket io] set up");

    socket.onConnect((data) async {
      log('[socket io] onConnect: ');
      debugPrint(data);

      await _repository.authToken.then((accessToken) {
        log("message [socket io]: accesstoken: >$accessToken<");
        if (accessToken != null && accessToken.isNotEmpty) {
          socket.emit('auth:connect', accessToken);
        } else {
          _messageStore.setErrorMessageByCode(401);

          socket.dispose();

          success = false;
        }
      });
    });

    // listen event
    socket.on('notification', (data) {
      log("[socket io] data from notification event");
      debugPrint(data);
    });

    socket.connect();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<Map<String, dynamic>?> emptyResponse =
      ObservableFuture.value(null);

  // non-observable variables:--------------------------------------------------
  ChatRoomInformation? chatRoomInformation;
  RoomInformation? roomInformation;

  // observable variables:------------------------------------------------------
  @observable
  bool success = false;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestFuture = emptyResponse;

  @observable
  ObservableList<ChatMessage> chatMessages = ObservableList<ChatMessage>();

  // computed:------------------------------------------------------------------
  @computed
  bool get isLoading => requestFuture.status == FutureStatus.pending;

  @computed
  String get getSuccessMessageKey => _messageStore.successMessagekey;

  @computed
  String get getFailedMessageKey => _messageStore.errorMessagekey;

  // actions:-------------------------------------------------------------------

  @action
  Future<bool> getChatRoomInformation(
    int sessionId,
  ) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      _messageStore.setErrorMessageByCode(401);

      success = false;

      return Future.value(false);
    }

    final future = _repository.getChatRoomInformation(
      authToken: accessToken,
      sessionId: sessionId,
    );

    requestFuture = ObservableFuture(future);

    return await future.then((res) async {
      try {
        if (res!["statusCode"] == null) {
          // [TODO] implement here
          chatRoomInformation = ChatRoomInformation.fromJson(res);

          await getRoomInformation(roomId: chatRoomInformation!.id);

          success = true;
        } else {
          int code = res["statusCode"] as int;

          _messageStore.setErrorMessageByCode(code);

          success = false;
        }
      } catch (e) {
        _messageStore.setErrorMessageByCode(500);

        success = false;
      }
      return Future.value(success);
    });
  }

  @action
  Future<void> getAllRooms() async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      _messageStore.setErrorMessageByCode(401);

      success = false;

      return;
    }

    final future = _repository.getAllRooms(
      authToken: accessToken,
    );

    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          // [TODO] implement here

          success = true;
        } else {
          int code = res["statusCode"] as int;

          _messageStore.setErrorMessageByCode(code);

          success = false;
        }
      } catch (e) {
        _messageStore.setErrorMessageByCode(500);

        success = false;
      }
    });
  }

  @action
  Future<bool> getRoomInformation({
    required int roomId,
  }) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      _messageStore.setErrorMessageByCode(401);

      success = false;

      return Future.value(false);
    }

    final future = _repository.getRoomInformation(
      authToken: accessToken,
      roomId: roomId,
    );

    requestFuture = ObservableFuture(future);

    return await future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          // [TODO] implement here
          roomInformation = RoomInformation.fromJson(res);

          success = true;
        } else {
          int code = res["statusCode"] as int;

          _messageStore.setErrorMessageByCode(code);

          success = false;
        }
      } catch (e) {
        _messageStore.setErrorMessageByCode(500);

        success = false;
      }
      return Future.value(success);
    });
  }

  @action
  Future<void> sendMessage({
    required int roomId,
    required String message,
  }) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      _messageStore.setErrorMessageByCode(401);

      success = false;

      return;
    }

    final future = _repository.sendMessage(
      authToken: accessToken,
      roomId: roomId,
      message: message,
    );

    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          // [TODO] implement here

          success = true;
        } else {
          int code = res["statusCode"] as int;

          _messageStore.setErrorMessageByCode(code);

          success = false;
        }
      } catch (e) {
        _messageStore.setErrorMessageByCode(500);

        success = false;
      }
    });
  }

  @action
  Future<void> fetchAllMessages(
    int roomId, [
    Map<String, int> params = const {
      "limit": 20,
      "skip": 0,
    },
  ]) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      _messageStore.setErrorMessageByCode(401);

      success = false;

      return;
    }

    final future = _repository.getAllMessages(
      authToken: accessToken,
      roomId: roomId,
      parameters: params,
    );

    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          // [TODO] implement here
          chatMessages =
              ObservableList.of(ChatMessageList.fromJson(res).chatMessages);

          success = true;
        } else {
          int code = res["statusCode"] as int;

          _messageStore.setErrorMessageByCode(code);

          success = false;
        }
      } catch (e) {
        _messageStore.setErrorMessageByCode(500);

        success = false;
      }
    });
  }

  // general methods:-----------------------------------------------------------

  void dispose() {
    for (final d in _disposers) {
      d();
    }

    // disconnect to websocket
  }
}
