import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:provider/provider.dart';

class AvatarChanger extends StatefulWidget {
  const AvatarChanger({
    Key? key,
    this.onChangeAvatar,
  }) : super(key: key);

  final ValueChanged<File?>? onChangeAvatar;

  @override
  _AvatarChangerState createState() => _AvatarChangerState();
}

class _AvatarChangerState extends State<AvatarChanger> {
  // controller:----------------------------------------------------------------

  // store:---------------------------------------------------------------------
  late final UserStore _userStore;
  final ThemeStore _themeStore = getIt<ThemeStore>();

  // variable:------------------------------------------------------------------
  File? image;
  // XFile? xImage;

  final ImagePicker imagePicker = ImagePicker();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context);
  }

  Future<XFile?> pickImageFromGallery() async {
    try {
      XFile? xImage = await imagePicker.pickImage(source: ImageSource.gallery);

      return Future.value(xImage);
    } on PlatformException catch (e) {
      log("message $e");
    }

    return Future.value(null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
          vertical: Dimens.vertical_padding,
          horizontal: Dimens.horizontal_padding),
      margin: const EdgeInsets.symmetric(
        vertical: Dimens.vertical_margin,
        horizontal: Dimens.horizontal_margin,
      ),
      child: Ink(
        child: InkWell(
            onTap: () async {
              await pickImageFromGallery().then((XFile? xImage) {
                if (null != xImage) {
                  setState(() {
                    image = File(xImage.path);
                    widget.onChangeAvatar?.call(image);
                  });
                }
              });
            },
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      const BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(-3, 5)),
                      BoxShadow(
                          color: _themeStore.reverseThemeColorfulColor,
                          spreadRadius: 5,
                          offset: const Offset(-2, 2)),
                    ],
                  ),
                  child: SizedBox(
                    width: DeviceUtils.getScaledWidth(context, .36),
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: ClipOval(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: image != null
                              ? Image.file(image!)
                              : NetworkImageWidget(
                                  url: _userStore.user?.avatar,
                                  radius: 50,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: Dimens.extra_large_vertical_margin,
                ),
                Text(
                  AppLocalizations.of(context)
                      .translate("change_profile_photo_label_translate"),
                  style: TextStyle(
                    fontSize: Dimens.small_text,
                    color: _themeStore.reverseThemeColor,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
