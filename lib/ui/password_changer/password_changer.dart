import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/constants/strings.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/authen_form/authen_form_store.dart';
import 'package:mobile/stores/enum/form_validation_status.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/app_icon_widget.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/progress_indicator_widget.dart';
import 'package:mobile/widgets/button_widgets/rounded_button_widget.dart';
import 'package:mobile/widgets/textfield/textfield_widget.dart';
import 'package:provider/provider.dart';

class PasswordChangerScreen extends StatefulWidget {
  const PasswordChangerScreen({Key? key}) : super(key: key);

  @override
  State<PasswordChangerScreen> createState() => _PasswordChangerScreenState();
}

class _PasswordChangerScreenState extends State<PasswordChangerScreen> {
// store:-------------------------------------
  final AuthenticatorFormStore _formStore = AuthenticatorFormStore();
  final ThemeStore _themeStore = getIt<ThemeStore>();

  late final UserStore _userStore;

  // controllers:-----------------------------------------------------------
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _recurrentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _userStore = Provider.of<UserStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LinearGradientBackground(
            colors: _themeStore.linearGradientColors,
            stops: _themeStore.linearGradientStops,
          ),
          SafeArea(
            child: Center(
              child: GlassmorphismContainer(
                blur: Properties.blur_glass_morphism,
                opacity: Properties.opacity_glass_morphism,
                padding: const EdgeInsets.symmetric(
                    vertical: Dimens.vertical_padding * 2),
                child: _buildContent(),
              ),
            ),
          ),
          Observer(
            // validator
            builder: (_) {
              return _formStore.success
                  ? _showSuccessMessage(
                      _formStore.messageStore.errorMessage,
                      duration: Properties.delayTimeInSecond,
                    )
                  : _showErrorMessage(
                      _formStore.messageStore.errorMessage,
                      duration: Properties.delayTimeInSecond,
                    );
            },
          ),
          Observer(
            builder: (_) {
              return Visibility(
                visible: _userStore.isLoading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.horizontal_padding * 2),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Hero(
              tag: Strings.authorizeHeroTag,
              child: AppIconWidget(
                image: 'assets/icons/ic_appicon.png',
                dimenImage: Dimens.ultra_large_text,
              ),
            ),
            const SizedBox(height: Dimens.horizontal_padding * 2),
            _buildCurrentPasswordField(),
            _buildReCurrentPasswordField(),
            _buildNewPasswordField(),
            _buildChangingButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPasswordField() {
    return Container(
      alignment: Alignment.center,
      height: Dimens.text_field_height,
      child: Observer(
        builder: (_) => TextFieldWidget(
          hint: AppLocalizations.of(context).translate('current_password'),
          inputType: TextInputType.text,
          isObscure: true,
          iconData: Icons.key,
          textController: _currentPasswordController,
          inputAction: TextInputAction.done,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setPassword(_currentPasswordController.text);
          },
          errorText: _formStore.formErrorStore.password,
        ),
      ),
    );
  }

  Widget _buildReCurrentPasswordField() {
    return Container(
      alignment: Alignment.center,
      height: Dimens.text_field_height,
      child: Observer(
        builder: (_) => TextFieldWidget(
          hint: AppLocalizations.of(context).translate('recurrent_password'),
          inputType: TextInputType.text,
          isObscure: true,
          iconData: Icons.key,
          textController: _recurrentPasswordController,
          inputAction: TextInputAction.done,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setConfirmPassword(_recurrentPasswordController.text);
          },
          errorText: _formStore.formErrorStore.confirmPassword,
        ),
      ),
    );
  }

  Widget _buildNewPasswordField() {
    return Container(
      alignment: Alignment.center,
      height: Dimens.text_field_height,
      child: Observer(
        builder: (_) => TextFieldWidget(
          hint: AppLocalizations.of(context).translate('new_password'),
          inputType: TextInputType.text,
          isObscure: true,
          iconData: Icons.key,
          textController: _newPasswordController,
          inputAction: TextInputAction.done,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setNewPassword(_newPasswordController.text);
          },
          errorText: _formStore.formErrorStore.newPassword,
        ),
      ),
    );
  }

  Widget _buildChangingButton() {
    return Container(
      margin: const EdgeInsets.only(
        top: Dimens.large_vertical_margin,
      ),
      child: RoundedButtonWidget(
        buttonText: AppLocalizations.of(context).translate("change_password"),
        buttonColor: Colors.transparent,
        textColor: _themeStore.reverseThemeColorfulColor,
        onPressed: () async {
          DeviceUtils.hideKeyboard(context);
          FormStatus formStatus = _formStore.renewPasswordStatus;

          switch (formStatus) {
            case FormStatus.allValidated:
              // call api to change password
              _formStore.changePassword();
              break;
            case FormStatus.missingField:
              _showErrorMessage(
                  AppLocalizations.of(context).translate("missing_field"));
              break;
            case FormStatus.notMatchPassword:
              _showErrorMessage(
                  AppLocalizations.of(context).translate("not_match_password"));
              break;
            default:
              break;
          }
        },
      ),
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message,
      {int duration = Properties.delayTimeInSecond}) {
    if (message.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('missing_field'),
          duration: Duration(seconds: duration),
        ).show(context);
      });
    }

    return const SizedBox.shrink();
  }

  _showSuccessMessage(String message,
      {int duration = Properties.delayTimeInSecond}) {
    if (message.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FlushbarHelper.createSuccess(
          message: message,
          title: AppLocalizations.of(context).translate('missing_field'),
          duration: Duration(seconds: duration),
        ).show(context);
      });
    }

    return const SizedBox.shrink();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _recurrentPasswordController.dispose();
    _newPasswordController.dispose();
    _formStore.dispose();

    super.dispose();
  }
}
