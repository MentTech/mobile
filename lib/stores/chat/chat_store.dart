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
import 'package:uuid/uuid.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling error messages
  final MessageStore _messageStore = getIt<MessageStore>();

  // websocket
  // static const String apiUrl = "https://api.menttech.live";
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
  @action
  Future connectSocket() async {
    // socket setup
    connectFuture = FutureStatus.pending;
    chats.clear();

    await _repository.authToken.then((accessToken) {
      if (accessToken != null && accessToken.isNotEmpty) {
        log("[Chat] [socket io] set up");

        socket.connect();

        socket.emit('auth:connect', accessToken);

        socket.onConnect((data) {
          log("[Chat] [socket io] connected " + socket.connected.toString());
          log('[Chat] [socket io] onConnect: ' + data.toString());

          successInConnectSocket = true;
          connectFuture = FutureStatus.fulfilled;
        });

        socket.onConnectError((data) {
          log("[Chat] [socket io] [onConnectError] " + data.toString());
          connectFuture = FutureStatus.fulfilled;
        });

        socket.onError((data) {
          log("[Chat] [socket io] [onError] " + data.toString());
          connectFuture = FutureStatus.fulfilled;
        });

        if (socket.connected) {
          connectFuture = FutureStatus.fulfilled;
        }

        socket.on('chat:${chatRoomInformation!.id}', (data) {
          log("[Chat] [socket io] [on receive chat] " + data.toString());
          addNewMessageFromSocket(data);
        });
      } else {
        _messageStore.setErrorMessageByCode(401);
        connectFuture = FutureStatus.fulfilled;

        socket.dispose();

        success = false;
      }
    });
  } // connect to server by websocket

  Future disconnectSocket() async {
    socket.dispose();
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
        (_) => chats,
        (_) {
          log("[chat] reacted types Message to update");
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

  final types.User defaultMentor = types.User(
    id: const Uuid().v4(),
    // lastName: "Mentor",
    imageUrl:
        "https://www.gravatar.com/avatar/460d94fc5806df528296a0f9447d4ceb?s=200",
  );

  types.User? mentorData;

  types.User? userData;

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
  ObservableFuture<Map<String, dynamic>?> requestChatRoomInformationFuture =
      emptyResponse;

  @observable
  FutureStatus connectFuture = FutureStatus.fulfilled;

  // @observable
  // ObservableList<ChatMessage> chatMessages = ObservableList<ChatMessage>();

  @observable
  ObservableList<types.TextMessage> chats = ObservableList<types.TextMessage>();

  // computed:------------------------------------------------------------------
  @computed
  bool get isLoading => requestFuture.status == FutureStatus.pending;

  @computed
  bool get isInitting =>
      requestChatRoomInformationFuture.status == FutureStatus.pending;

  @computed
  bool get isConnecting => connectFuture == FutureStatus.pending;

  @computed
  String get getSuccessMessageKey => _messageStore.successMessagekey;

  @computed
  String get getFailedMessageKey => _messageStore.errorMessagekey;

  @computed
  ObservableList<types.Message> get typesMessageChats => chats;

  // actions:-------------------------------------------------------------------

  @action
  Future<types.User?> getChatRoomInformation() async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      _messageStore.setErrorMessageByCode(401);

      successInGetRoom = false;

      return Future.value(null);
    }

    final future = _repository.getChatRoomInformation(
      authToken: accessToken,
      sessionId: _sessionId,
    );

    requestChatRoomInformationFuture = ObservableFuture(future);

    // log("[Chat] [getChatRoomInformation] requestChatRoomInformationFuture: ${requestChatRoomInformationFuture.status}");

    return future.then((res) async {
      // log("[Chat] [getChatRoomInformation] requestChatRoomInformationFuture when done: ${requestChatRoomInformationFuture.status}");
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

          final Participant mentorParticipant =
              chatRoomInformation!.participants[0];

          mentorData = types.User(
            id: mentorParticipant.id.toString(),
            // lastName: participant.name,
            imageUrl: mentorParticipant.avatar,
          );

          final Participant userParticipant =
              chatRoomInformation!.participants[1];

          userData = types.User(
            id: userParticipant.id.toString(),
            // lastName: participant.name,
            imageUrl: userParticipant.avatar,
          );

          return Future.value(mentorData);
        } else {
          int code = res["statusCode"] as int;

          _messageStore.setErrorMessageByCode(code);

          successInGetRoom = false;
        }
      } catch (e) {
        _messageStore.setErrorMessageByCode(500);

        successInGetRoom = false;
      }

      return Future.value(null);
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

    // requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          // [TODO] implement here
          final chatMessage = ChatMessage.fromJson(res);

          for (var i = 0; i < chats.length; i++) {
            final chat = chats.elementAt(i);
            if (chat.status == types.Status.sending &&
                chat.text.compareTo(chatMessage.content) == 0) {
              chats.removeAt(i);
              chats.insert(
                  i,
                  chat.copyWith(
                    id: chatMessage.id.toString(),
                    status: types.Status.sent,
                  ) as types.TextMessage);

              break;
            }
          }

          // for (var chat in chats) {
          //   if (chat.status == types.Status.sending &&
          //       chat.text.compareTo(chatMessage.content) == 0) {
          //     chat = chat.copyWith(
          //       id: chatMessage.id.toString(),
          //       status: types.Status.sent,
          //     ) as types.TextMessage;

          //     break;
          //   }
          // }

          successInGetMessage = true;
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

    log("[chat] fetch message");

    await Future.doWhile(() async {
      if ((mentorData != null && userData != null)) {
        return false;
      }

      log("[chat] request until has data");

      await getChatRoomInformation();

      return true;
    });

    future.then((res) {
      try {
        if (res!["statusCode"] == null) {
          // [TODO] implement here

          final chatMessages = ChatMessageList.fromJson(res).chatMessages;

          log("[chat] fetched message with length: ${chatMessages.length}");

          chats.clear();
          for (var element in chatMessages) {
            pushBackToChats(element);
          }

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
    final chatMessage = ChatMessage.fromJson(data);

    // if (chatMessage.userId.toString().compareTo(userData!.id) == 0) {
    //   for (var chat in chats) {
    //     if (chat.status == types.Status.sending &&
    //         chat.text.compareTo(chatMessage.content) == 0) {
    //       chat = chat.copyWith(
    //         id: chatMessage.id.toString(),
    //         status: types.Status.sent,
    //       ) as types.TextMessage;

    //       break;
    //     }
    //   }
    // } else {
    //   pushFontToChats(chatMessage);
    // }

    pushFontToChats(chatMessage);

    successInGetMessage = true;
  }

  @action
  void pushFontToChats(ChatMessage element) {
    if (element.userId.toString().compareTo(mentorData!.id) == 0) {
      chats.insert(
        0,
        types.TextMessage(
          author: types.User(
            id: element.userId.toString(),
            imageUrl: mentorData!.imageUrl, // difference image url
          ),
          id: element.id.toString(),
          text: element.content,
          createdAt: element.createAt.millisecondsSinceEpoch,
          status: types.Status.seen,
        ),
      );
    } else {
      chats.insert(
        0,
        types.TextMessage(
          author: types.User(
            id: element.userId.toString(),
            imageUrl: userData!.imageUrl, // difference image url
          ),
          id: element.id.toString(),
          text: element.content,
          createdAt: element.createAt.millisecondsSinceEpoch,
          status: types.Status.seen,
        ),
      );
    }
  }

  @action
  void pushBackToChats(ChatMessage element) {
    if (element.userId.toString().compareTo(mentorData!.id) == 0) {
      chats.add(
        types.TextMessage(
          author: types.User(
            id: element.userId.toString(),
            imageUrl: mentorData!.imageUrl, // difference image url
          ),
          id: element.id.toString(),
          text: element.content,
          createdAt: element.createAt.millisecondsSinceEpoch,
          status: types.Status.seen,
        ),
      );
    } else {
      chats.add(
        types.TextMessage(
          author: types.User(
            id: element.userId.toString(),
            imageUrl: userData!.imageUrl, // difference image url
          ),
          id: element.id.toString(),
          text: element.content,
          createdAt: element.createAt.millisecondsSinceEpoch,
          status: types.Status.seen,
        ),
      );
    }
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
