import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/authen_form/editable_user_infor_form_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/textfield_widget.dart';

class UserEditablePopup extends StatefulWidget {
  const UserEditablePopup({Key? key}) : super(key: key);

  @override
  State<UserEditablePopup> createState() => _UserEditablePopupState();
}

class _UserEditablePopupState extends State<UserEditablePopup> {
  // Store:---------------------------------------------------------------------
  final ThemeStore themeStore = getIt<ThemeStore>();
  final UserInforEditorFormStore _userInforEditorFormStore =
      UserInforEditorFormStore();

  // Controller:----------------------------------------------------------------
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _birthdayEditingController =
      TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildNameField(context),
          _buildBirthdayField(context),
          _buildPhoneField(context),
        ],
      ),
    );
  }

  Widget _buildNameField(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: Dimens.text_field_height,
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('login_et_user_email'),
            inputType: TextInputType.emailAddress,
            icon: Icons.person,
            iconColor: themeStore.textTitleColor,
            textController: _nameEditingController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            onChanged: (value) {
              _userInforEditorFormStore.setName(_nameEditingController.text);
            },
            errorText: _userInforEditorFormStore.formErrorStore.errorOnName,
          );
        },
      ),
    );
  }

  Widget _buildPhoneField(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: Dimens.text_field_height,
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('login_et_user_email'),
            inputType: TextInputType.phone,
            icon: Icons.phone_android_rounded,
            iconColor: themeStore.textTitleColor,
            textController: _phoneEditingController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            onChanged: (value) {
              _userInforEditorFormStore.setPhone(_phoneEditingController.text);
            },
            errorText: _userInforEditorFormStore.formErrorStore.errorOnPhone,
          );
        },
      ),
    );
  }

  Widget _buildBirthdayField(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: Dimens.text_field_height,
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('login_et_user_email'),
            inputType: TextInputType.datetime,
            icon: Icons.person,
            iconColor: themeStore.textTitleColor,
            textController: _birthdayEditingController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            onChanged: (value) {
              _userInforEditorFormStore
                  .setBirthday(_birthdayEditingController.text);
            },
            errorText: _userInforEditorFormStore.formErrorStore.errorOnBirthday,
          );
        },
      ),
    );
  }
}
