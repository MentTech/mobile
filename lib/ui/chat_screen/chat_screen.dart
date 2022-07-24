import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/chat/chat_room_information.dart';
import 'package:mobile/stores/chat/chat_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/utils/application/application_utils.dart';
import 'package:mobile/widgets/progress_indicator_widget.dart';
import 'package:mobile/widgets/template/glassmorphism_appbar_only.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatStore _chatStore = getIt<ChatStore>();
  late final UserStore _userStore;

  late final types.User _user;

  List<types.Message> messages = [];

  @override
  void initState() {
    super.initState();

    _userStore = Provider.of<UserStore>(context, listen: false);
    _user = types.User(
        id: _userStore.user!.id.toString(),
        lastName: _userStore.user!.name,
        imageUrl: _userStore.user!.avatar);

    _chatStore.getChatRoomInformation();

    // log("[Chat] [initState] _chatStore.isLoading: ${_chatStore.isLoading} || _chatStore.isConnecting: ${_chatStore.isConnecting}");
  }

  @override
  void dispose() {
    _chatStore.disconnectSocket();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) {
          log("[chat] changed to update");
          ChatRoomInformation? chatRoom = _chatStore.chatRoomInformation;
          return GlassmorphismGradientScaffoldAppbar(
            appbarName: chatRoom?.name ?? "Session's name",
            appbarTitleColor: AppColors.darkTextTheme,
            child: Observer(
              builder: (_) {
                log("[chat] [typesMessageChats] changed to update + length: ${_chatStore.typesMessageChats.length}");
                messages = _chatStore.typesMessageChats;
                _chatStore.successInGetMessage;

                return Chat(
                  messages: messages,
                  onAttachmentPressed: null,
                  onMessageTap: null,
                  onPreviewDataFetched: null,
                  onSendPressed: _handleSendPressed,
                  showUserAvatars: true,
                  showUserNames: true,
                  user: _user,
                  theme: DefaultChatTheme(
                    attachmentButtonIcon: null,
                    attachmentButtonMargin: null,
                    backgroundColor: Colors.white70,
                    dateDividerMargin: const EdgeInsets.only(
                      bottom: Dimens.lightly_medium_vertical_margin,
                      top: Dimens.extra_large_vertical_margin,
                    ),
                    dateDividerTextStyle: const TextStyle(
                      color: AppColors.darkTextTheme,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                    deliveredIcon: null,
                    documentIcon: null,
                    emptyChatPlaceholderTextStyle: const TextStyle(
                      color: neutral2,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                    errorColor: const Color(0xffff6767),
                    errorIcon: null,
                    inputBackgroundColor: Theme.of(context).primaryColor,
                    inputBorderRadius: const BorderRadius.vertical(
                      top: Radius.circular(Dimens.kBorderMaxRadiusValue),
                    ),
                    inputContainerDecoration: null,
                    inputMargin: EdgeInsets.zero,
                    inputPadding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                    inputTextColor: Theme.of(context).highlightColor,
                    inputTextCursorColor: Theme.of(context).highlightColor,
                    inputTextDecoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isCollapsed: true,
                    ),
                    inputTextStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                    messageBorderRadius: 20,
                    messageInsetsHorizontal: Dimens.horizontal_padding,
                    messageInsetsVertical: Dimens.vertical_padding,
                    primaryColor: Theme.of(context).primaryColor,
                    receivedEmojiMessageTextStyle:
                        const TextStyle(fontSize: 40),
                    receivedMessageBodyBoldTextStyle: null,
                    receivedMessageBodyCodeTextStyle: null,
                    receivedMessageBodyLinkTextStyle: null,
                    receivedMessageBodyTextStyle: const TextStyle(
                      color: neutral7,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                    receivedMessageCaptionTextStyle: const TextStyle(
                      color: neutral7WithOpacity,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.333,
                    ),
                    receivedMessageDocumentIconColor:
                        Theme.of(context).primaryColor,
                    receivedMessageLinkDescriptionTextStyle: const TextStyle(
                      color: neutral7,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.428,
                    ),
                    receivedMessageLinkTitleTextStyle: const TextStyle(
                      color: neutral7,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      height: 1.375,
                    ),
                    secondaryColor:
                        Theme.of(context).primaryColor.withOpacity(0.5),
                    seenIcon: null,
                    sendButtonIcon: null,
                    sendButtonMargin: null,
                    sendingIcon: null,
                    sentEmojiMessageTextStyle: const TextStyle(fontSize: 40),
                    sentMessageBodyBoldTextStyle: null,
                    sentMessageBodyCodeTextStyle: null,
                    sentMessageBodyLinkTextStyle: null,
                    sentMessageBodyTextStyle: const TextStyle(
                      color: neutral7,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                    sentMessageCaptionTextStyle: const TextStyle(
                      color: neutral7WithOpacity,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.333,
                    ),
                    sentMessageDocumentIconColor: neutral7,
                    sentMessageLinkDescriptionTextStyle: const TextStyle(
                      color: neutral7,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.428,
                    ),
                    sentMessageLinkTitleTextStyle: const TextStyle(
                      color: neutral7,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      height: 1.375,
                    ),
                    statusIconPadding:
                        const EdgeInsets.symmetric(horizontal: 4),
                    userAvatarImageBackgroundColor: Colors.transparent,
                    userAvatarNameColors: colors,
                    userAvatarTextStyle: const TextStyle(
                      color: neutral7,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      height: 1.333,
                    ),
                    userNameTextStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      height: 1.333,
                    ),
                  ),
                );
              },
            ),
            messageNotification: Observer(
              builder: (_) {
                return _chatStore.successInGetRoom
                    ? ApplicationUtils.showSuccessMessage(
                        context,
                        "chatroom_title_translate",
                        _chatStore.getSuccessMessageKey, action: () {
                        _chatStore.connectSocket();
                        _chatStore.fetchAllMessages();
                      })
                    : _chatStore.successInGetMessage &&
                            _chatStore.successInConnectSocket
                        ? ApplicationUtils.showSuccessMessage(
                            context,
                            "chatroom_title_translate",
                            _chatStore.getSuccessMessageKey,
                          )
                        : const SizedBox.shrink();
              },
            ),
            progressIndicator: Observer(
              builder: (context) {
                // log("[Chat] [progressIndicator: Observer]  _chatStore.isInitting: ${_chatStore.isInitting} || _chatStore.isLoading: ${_chatStore.isLoading} || _chatStore.isConnecting: ${_chatStore.isConnecting}");
                return Visibility(
                  visible: _chatStore.isInitting ||
                      _chatStore.isLoading ||
                      _chatStore.isConnecting,
                  child: const CustomProgressIndicatorWidget(),
                );
              },
            ),
          );
        },
      );

  void _addMessage(types.TextMessage message) {
    setState(() {
      messages.insert(
        0,
        message.copyWith(status: types.Status.sending),
      );
    });
    _chatStore.sendMessage(message: message);
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }
}
