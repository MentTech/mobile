import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/assets.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/constants/strings.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/authen/authen_store.dart';
import 'package:mobile/stores/authen_form/authen_form_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/utils/application/application_utils.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/app_icon_widget.dart';
import 'package:mobile/widgets/appbar/custom_appbar_in_stack.dart';
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

  late final AuthenStore _authenStore;

  // controllers:-----------------------------------------------------------
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _reNewPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _authenStore = Provider.of<AuthenStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LinearGradientBackground(
            colors: _themeStore.lineToLineGradientColors,
            stops: null,
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
          CustomInStackAppBar(
            nameAppbar: AppLocalizations.of(context)
                .translate("change_password_translate"),
          ),
          Observer(
            // validator
            builder: (_) {
              return _authenStore.success
                  ? ApplicationUtils.showSuccessMessage(
                      context,
                      "change_password_title_translate",
                      _authenStore.getSuccessMessageKey,
                    )
                  : ApplicationUtils.showErrorMessage(
                      context,
                      "change_password_title_translate",
                      _authenStore.getFailedMessageKey,
                    );
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _authenStore.isLoading,
                child: const CustomProgressIndicatorWidget(),
              );
            },
          ),
        ],
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
            const Hero(
              tag: Strings.authorizeHeroTag,
              child: AppIconWidget(
                image: Assets.appLogo,
                dimenImage: Dimens.ultra_large_text,
              ),
            ),
            const SizedBox(height: Dimens.horizontal_padding * 2),
            _buildCurrentPasswordField(),
            _buildNewPasswordField(),
            _buildReNewPasswordField(),
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
            _formStore.setOldPassword(_currentPasswordController.text);
          },
          errorText: _formStore.formErrorStore.oldPassword,
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
            _formStore.setPassword(_newPasswordController.text);
          },
          errorText: _formStore.formErrorStore.password,
        ),
      ),
    );
  }

  Widget _buildReNewPasswordField() {
    return Container(
      alignment: Alignment.center,
      height: Dimens.text_field_height,
      child: Observer(
        builder: (_) => TextFieldWidget(
          hint: AppLocalizations.of(context).translate('renew_password'),
          inputType: TextInputType.text,
          isObscure: true,
          iconData: Icons.key,
          textController: _reNewPasswordController,
          inputAction: TextInputAction.done,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setConfirmPassword(_reNewPasswordController.text);
          },
          errorText: _formStore.formErrorStore.confirmPassword,
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
        textColor: Theme.of(context).primaryColor,
        onPressed: () async {
          DeviceUtils.hideKeyboard(context);
          _formStore.validatePasswordChanger();
          // [TODO]: validate + process here
          if (_formStore.canChangePassword) {
            _authenStore.changePassword(
              _formStore.oldPassword,
              _formStore.password,
            );
          }
        },
      ),
    );
  }

  // General Methods:-----------------------------------------------------------

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _reNewPasswordController.dispose();
    _formStore.dispose();

    super.dispose();
  }
}
