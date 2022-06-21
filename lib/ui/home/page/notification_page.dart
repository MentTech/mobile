import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({Key? key}) : super(key: key);

  // store:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        LinearGradientBackground(
          colors: _themeStore.lineToLineGradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.horizontal_padding,
              vertical: Dimens.vertical_padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              // Text(
              //   AppLocalizations.of(context).translate("message_title"),
              //   style: TextStyle(
              //     fontFamily: FontFamily.gilroy,
              //     fontSize: Dimens.largeText,
              //     color: Theme.of(context).primaryColor.withAlpha(200),
              //     letterSpacing: 2,
              //   ),
              // ),
              // const SizedBox(
              //   height: Dimens.verticalMargin,
              // ),
              // CustomTextInputForm(
              //   textEditingController: editingController,
              //   hintText: "message_search_bar",
              //   labelText: "message_search_bar",
              // ),
              // Expanded(
              //   child: Consumer<ListLastestMessage>(
              //     builder: (context, value, child) {
              //       return ListView.builder(
              //         physics: const BouncingScrollPhysics(),
              //         itemBuilder: (context, index) =>
              //             _buildItem(context, index, value),
              //         itemCount: value.lengthList,
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget _buildItem(BuildContext context, int index, ListLastestMessage llMes) {
  //   return LastestMessageCard(
  //     lastestMessage: llMes.getLastestMessageAt(index),
  //     onClickMessage: () {
  //       routeToMessageBox(index);
  //     },
  //   );
  // }

  // void routeToMessageBox(int index) {
  //   log('route message box');
  // }
}
