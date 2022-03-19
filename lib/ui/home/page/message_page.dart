import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/utils/device/device_utils.dart';

class MessagePage extends StatelessWidget {
  MessagePage({Key? key}) : super(key: key);

  final TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DeviceUtils.hideKeyboard(context),
      child: Container(
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
