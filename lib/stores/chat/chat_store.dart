// ignore_for_file: unused_field, unnecessary_getters_setters

import 'dart:developer';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
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
    Endpoints.apiUrl,
    io.OptionBuilder()
        .setTimeout(5000)
        .disableAutoConnect()
        .setTransports(['websocket']).build(),
  );

  // constructor:---------------------------------------------------------------
  _ChatStore(Repository repository) : _repository = repository {
    // setting up disposers
    _setupDisposers();

    // fetch all notifications when start app
    // fetchAllNotifications();
  }

  // connect to server by websocket
  Future connectSocket() async {
    // socket setup
    await _repository.authToken.then((accessToken) {
      if (accessToken != null && accessToken.isNotEmpty) {
        log("[Chat] [socket io] set up");

        socket.connect();

        socket.emit('auth:connect', accessToken);

        socket.onConnect((data) {
          log("[Chat] [socket io] connected " + socket.connected.toString());
          log('[Chat] [socket io] onConnect: ' + data.toString());

          successInConnectSocket = true;
        });

        socket.onConnectError((data) {
          log("[Chat] [socket io] [onConnectError]" + data.toString());
        });

        socket.onError((data) {
          log("[Chat] [socket io] [onError]" + data.toString());
        });

        // listen event
        socket.on('notification', (data) {
          log("[Chat] [socket io] data from notification event " +
              data.toString());
        });

        socket.on('chat:${roomInformation!.id}', (data) {
          addNewMessageFromSocket(data);
        });
      } else {
        _messageStore.setErrorMessageByCode(401);

        socket.dispose();

        success = false;
      }
    });
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
      reaction((_) => successInGetRoom, (_) => successInGetRoom = false,
          delay: 200),
      reaction((_) => successInGetMessage, (_) => successInGetMessage = false,
          delay: 200),
      reaction(
          (_) => successInConnectSocket, (_) => successInConnectSocket = false,
          delay: 200),
      reaction(
        (_) => chatMessages,
        (_) {
          for (var element in chatMessages) {
            chats.add(
              types.TextMessage(
                author: types.User(
                  id: element.userId.toString(),
                ),
                id: element.id.toString(),
                text: element.content,
              ),
            );
          }
        },
        delay: 200,
      ),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<Map<String, dynamic>?> emptyResponse =
      ObservableFuture.value(null);

  // non-observable variables:--------------------------------------------------
  ChatRoomInformation? chatRoomInformation;
  RoomInformation? roomInformation;

  int _sessionId = -1;
  set sessionID(int id) {
    _sessionId = id;
  }

  int _mentorId = -1;
  set mentorID(int id) {
    _mentorId = id;
  }

  int get mentorID => _mentorId;

  List<types.Message> chats = [];

  // observable variables:------------------------------------------------------
  @observable
  bool successInGetRoom = false;

  @observable
  bool successInConnectSocket = false;

  @observable
  bool successInGetMessage = false;

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
  Future<bool> getChatRoomInformation() async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      _messageStore.setErrorMessageByCode(401);

      successInGetRoom = false;

      return Future.value(false);
    }

    final future = _repository.getChatRoomInformation(
      authToken: accessToken,
      sessionId: _sessionId,
    );

    requestFuture = ObservableFuture(future);

    return await future.then((res) async {
      try {
        if (res!["statusCode"] == null) {
          // [TODO] implement here
          chatRoomInformation = ChatRoomInformation.fromJson(res);

          if (chatRoomInformation!.participants.isNotEmpty) {
            successInGetRoom = true;
          } else {
            successInGetRoom =
                await getRoomInformation(roomId: chatRoomInformation!.id);
          }

          _messageStore.setSuccessMessage(Code.getChatRoom);
        } else {
          int code = res["statusCode"] as int;

          _messageStore.setErrorMessageByCode(code);

          successInGetRoom = false;
        }
      } catch (e) {
        _messageStore.setErrorMessageByCode(500);

        successInGetRoom = false;
      }

      return Future.value(successInGetRoom);
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

      successInGetRoom = false;

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
          chatRoomInformation!.participants
              .addAll(roomInformation!.participants);

          successInGetRoom = true;
        } else {
          int code = res["statusCode"] as int;

          _messageStore.setErrorMessageByCode(code);

          successInGetRoom = false;
        }
      } catch (e) {
        _messageStore.setErrorMessageByCode(500);

        successInGetRoom = false;
      }
      return Future.value(successInGetRoom);
    });
  }

  @action
  Future<void> sendMessage({
    required types.TextMessage message,
  }) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      _messageStore.setErrorMessageByCode(401);

      success = false;

      return;
    }

    final future = _repository.sendMessage(
      authToken: accessToken,
      roomId: chatRoomInformation!.id,
      message: message.text.trim(),
    );

    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          // [TODO] implement here
          ChatMessage chatMessage = ChatMessage.fromJson(res);

          for (var chat in chatMessages) {
            if (chat.content.compareTo(chatMessage.content) == 0) {
              chat = chatMessage;
            }
          }

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
  Future<void> fetchAllMessages([
    Map<String, int> params = const {
      "limit": 40,
      "skip": 0,
    },
  ]) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      _messageStore.setErrorMessageByCode(401);

      successInGetMessage = false;

      return;
    }

    final future = _repository.getAllMessages(
      authToken: accessToken,
      roomId: chatRoomInformation!.id,
      parameters: params,
    );

    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          // [TODO] implement here
          chatMessages =
              ObservableList.of(ChatMessageList.fromJson(res).chatMessages);

          successInGetMessage = true;
        } else {
          int code = res["statusCode"] as int;

          _messageStore.setErrorMessageByCode(code);

          successInGetMessage = false;
        }
      } catch (e) {
        _messageStore.setErrorMessageByCode(500);

        successInGetMessage = false;
      }
    });
  }

  @action
  void addNewMessageFromSocket(dynamic data) {
    chatMessages.add(ChatMessage.fromJson(data));
  }

  // @action
  // void addNewMessageFromUser(String message) {
  //   socket.emit('chat:send_message', {
  //       "roomId": Number(router.query.roomId),
  //       "message":message,
  //     });
  //   chatMessages.add(ChatMessage.fromJson(data));
  // }

  // general methods:-----------------------------------------------------------

  void dispose() {
    for (final d in _disposers) {
      d();
    }

    // disconnect to websocket
  }
}
