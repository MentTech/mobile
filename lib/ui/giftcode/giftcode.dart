import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/stores/form/giftcode_form_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/utils/application/application_utils.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/button_widgets/rounded_button_widget.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/progress_indicator_widget.dart';
import 'package:mobile/widgets/template/glassmorphism_appbar_only.dart';
import 'package:mobile/widgets/textfield/textfield_widget.dart';
import 'package:provider/provider.dart';

class GiftCodeScreen extends StatefulWidget {
  const GiftCodeScreen({Key? key}) : super(key: key);

  @override
  State<GiftCodeScreen> createState() => _GiftCodeScreenState();
}

class _GiftCodeScreenState extends State<GiftCodeScreen> {
// store:-------------------------------------
  final GiftcodeFormStore _giftcodeFormStore = GiftcodeFormStore();

  late final UserStore _userStore;

  // controllers:-----------------------------------------------------------
  final TextEditingController _giftcodeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _userStore = Provider.of<UserStore>(context, listen: false);
  }

  @override
  void dispose() {
    _giftcodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphismGradientScaffoldAppbar(
      appbarName:
          AppLocalizations.of(context).translate("giftcode_title_translate"),
      child: Center(
        child: GlassmorphismContainer(
          blur: Properties.blur_glass_morphism,
          opacity: Properties.opacity_glass_morphism,
          padding:
              const EdgeInsets.symmetric(vertical: Dimens.vertical_padding * 2),
          child: _buildContent(),
        ),
      ),
      messageNotification: Observer(
        builder: (_) {
          return _userStore.success
              ? ApplicationUtils.showSuccessMessage(
                  context,
                  "giftcode_title_translate",
                  _userStore.getSuccessMessageKey,
                )
              : ApplicationUtils.showErrorMessage(
                  context,
                  "giftcode_title_translate",
                  _userStore.getFailedMessageKey,
                );
        },
      ),
      progressIndicator: Observer(
        builder: (context) {
          return Visibility(
            visible: _userStore.isLoading,
            child: const CustomProgressIndicatorWidget(),
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.large_horizontal_padding),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: Dimens.text_field_height,
              child: Observer(
                builder: (_) => TextFieldWidget(
                  hint: AppLocalizations.of(context)
                      .translate('giftcode_translate'),
                  inputType: TextInputType.text,
                  isObscure: false,
                  iconData: Icons.redeem_rounded,
                  textController: _giftcodeController,
                  inputAction: TextInputAction.done,
                  autoFocus: false,
                  onChanged: (value) {
                    _giftcodeFormStore
                        .setApplyGiftcode(_giftcodeController.text);
                  },
                  errorText: _giftcodeFormStore.formErrorStore.giftcode,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: Dimens.large_vertical_margin,
              ),
              child: RoundedButtonWidget(
                buttonText: AppLocalizations.of(context)
                    .translate("receive_giftcode_translate"),
                buttonColor: Colors.transparent,
                textColor: Theme.of(context).highlightColor,
                onPressed: () async {
                  DeviceUtils.hideKeyboard(context);
                  _giftcodeFormStore.validateAll();
                  if (_giftcodeFormStore.canApplyGiftcode) {
                    _userStore.applyGiftcode(
                      data: _giftcodeFormStore.toRequestJson(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
