import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/user/user.dart';
import 'package:mobile/stores/authen_form/user_info_form_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/ui/user_profile/avatar_changer.dart';
import 'package:mobile/utils/application/application_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/progress_indicator_widget.dart';
import 'package:mobile/widgets/textfield/textfield_name_before.dart';
import 'package:mobile/widgets/textfield/textfield_widget.dart';
import 'package:provider/provider.dart';
import 'package:mobile/utils/extension/datetime_extension.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  //text controllers:-----------------------------------------------------------
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  //stores:---------------------------------------------------------------------
  late final UserStore _userStore;
  late final UserInfoFormStore _formStore;
  final ThemeStore _themeStore = getIt<ThemeStore>();

  // attributes:----------------------------------------------------------------
  File? avatarImage;

  @override
  void initState() {
    super.initState();

    _userStore = Provider.of<UserStore>(context, listen: false);

    UserModel user = _userStore.user!;

    _emailController.text = user.email;
    _nameController.text = user.name;

    String birthdayString =
        (user.birthday ?? DateTime.now().subtractYear(year: 18))
            .toBirthdayString();
    _birthdayController.text = birthdayString;
    _phoneController.text = user.phone ?? "";

    _formStore = UserInfoFormStore(
      email: user.email,
      name: user.name,
      birthday: birthdayString,
      phone: user.phone ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          LinearGradientBackground(
            colors: _themeStore.lineToLineGradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: null,
          ),
          _buildContent(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeaderWidget(),
          ),
          Observer(
            // validator
            builder: (_) {
              return _userStore.success
                  ? ApplicationUtils.showSuccessMessage(
                      context,
                      "change_information_notification_title_translate",
                      _userStore.getSuccessMessageKey,
                    )
                  : ApplicationUtils.showErrorMessage(
                      context,
                      "change_information_notification_title_translate",
                      _userStore.getFailedMessageKey,
                    );
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _userStore.isLoading || _userStore.isUploadingAvatar,
                child: CustomProgressIndicatorWidget(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: kToolbarHeight,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.large_horizontal_padding,
              ),
              child: _buildFieldContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderWidget() {
    return GlassmorphismContainer(
      border: Theme.of(context).highlightColor,
      radius: 0,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Routes.popRoute(context);
              },
              child: Text(
                AppLocalizations.of(context)
                    .translate("cancel_button_translate"),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.red.shade600,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Text(
              AppLocalizations.of(context)
                  .translate("profile_editor_settings_translate"),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            TextButton(
              onPressed: () {
                // on Save
                _formStore.validateAll();
                if (_formStore.canUpdateUserInfor) {
                  _userStore.updateUserInformation(
                      data: _formStore.toDataJson());
                }
                if (null != avatarImage) {
                  _userStore.uploadUserAvatar(imageFile: avatarImage!);
                }
              },
              child: Text(
                AppLocalizations.of(context).translate("done_button_translate"),
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: AppColors.confirmColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
      ),
      blur: Properties.lightly_blur_glass_morphism,
      opacity: Properties.lightly_opacity_glass_morphism,
    );
  }

  Widget _buildFieldContent() {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: AvatarChanger(
              onChangeAvatar: ((file) {
                avatarImage = file;
              }),
            ),
          ),
          Divider(color: Theme.of(context).dividerColor),
          _buildEmaildField(),
          _buildNameField(),
          _buildBirthdayField(),
          _buildPhoneField(),
          Divider(color: Theme.of(context).dividerColor),
          const SizedBox(
            height: Dimens.vertical_margin,
          ),
        ],
      ),
    );
  }

  Widget _buildEmaildField() {
    return Observer(
      builder: (_) {
        return TextFieldNameWidget(
          labelText:
              AppLocalizations.of(context).translate("email_label_translate"),
          textInputType: TextInputType.emailAddress,
          errorText: _formStore.formErrorStore.email,
          controller: _emailController,
          textColor: Theme.of(context).indicatorColor,
          onValueChanged: (value) {
            _formStore.setEmail(_emailController.text);
          },
        );
      },
    );
  }

  Widget _buildNameField() {
    return Observer(
      builder: (_) {
        return TextFieldNameWidget(
          labelText:
              AppLocalizations.of(context).translate("name_label_translate"),
          textInputType: TextInputType.name,
          errorText: _formStore.formErrorStore.name,
          controller: _nameController,
          textColor: Theme.of(context).indicatorColor,
          onValueChanged: (value) {
            _formStore.setName(_nameController.text);
          },
        );
      },
    );
  }

  Widget _buildBirthdayField() {
    return Container(
      clipBehavior: Clip.none,
      margin: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              AppLocalizations.of(context)
                  .translate("birthday_label_translate"),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            flex: 15,
            child: Observer(
              builder: (_) {
                return TextFieldWidget(
                  hint: AppLocalizations.of(context)
                      .translate('birthday_label_translate'),
                  isIcon: false,
                  inputType: TextInputType.datetime,
                  textController: _birthdayController,
                  inputAction: TextInputAction.done,
                  autoFocus: false,
                  onChanged: (value) {
                    _formStore.setBirthday(_birthdayController.text);
                  },
                  errorText: _formStore.formErrorStore.birthday,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneField() {
    return Observer(
      builder: (_) {
        return TextFieldNameWidget(
          labelText:
              AppLocalizations.of(context).translate("phone_label_translate"),
          textInputType: TextInputType.phone,
          errorText: _formStore.formErrorStore.phone,
          controller: _phoneController,
          textColor: Theme.of(context).indicatorColor,
          onValueChanged: (value) {
            _formStore.setPhone(_phoneController.text);
          },
        );
      },
    );
  }

  // General Methods:-----------------------------------------------------------

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _emailController.dispose();
    _nameController.dispose();
    _birthdayController.dispose();
    _phoneController.dispose();

    super.dispose();
  }
}
