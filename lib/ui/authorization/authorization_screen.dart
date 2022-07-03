import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/assets.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/constants/strings.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/authen/authen_store.dart';
import 'package:mobile/stores/authen_form/authen_form_store.dart';
import 'package:mobile/stores/notification/notification_store.dart';
import 'package:mobile/stores/search_store.dart/search_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/utils/application/application_utils.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/app_icon_widget.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/button_widgets/sgv_button_widget.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/progress_indicator_widget.dart';
import 'package:mobile/widgets/button_widgets/rounded_button_widget.dart';
import 'package:mobile/widgets/text_view/text_widget.dart';
import 'package:mobile/widgets/textfield/textfield_widget.dart';
import 'package:provider/provider.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({Key? key}) : super(key: key);

  @override
  _AuthorizationScreenState createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen>
    with TickerProviderStateMixin {
  //text controllers:-----------------------------------------------------------
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  //stores:---------------------------------------------------------------------
  late final UserStore _userStore;
  late final SearchStore _searchStore;
  late final AuthenStore _authenStore;
  final AuthenticatorFormStore _store = AuthenticatorFormStore();
  final ThemeStore _themeStore = getIt<ThemeStore>();

  //focus node:-----------------------------------------------------------------
  final FocusNode _passwordFocusNode = FocusNode();

  // animate
  // ignore: unused_field
  late Animation<double> _authenAnimation;
  late AnimationController _authenAnimationController;

  // ignore: unused_field
  late Animation<double> _forgotPassowrdAnimation;
  late AnimationController _forgotPassowrdAnimationController;

  @override
  void initState() {
    super.initState();

    _authenAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: Properties.animatedTimeInMiliSecond,
      ),
    );
    _authenAnimation = Tween<double>(
      begin: 0,
      end: Properties.animatedTimeInMiliSecond * 1.0,
    ).animate(_authenAnimationController)
      ..addListener(() {
        setState(() {});
      });

    _forgotPassowrdAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: Properties.animatedTimeInMiliSecond,
      ),
    );
    _forgotPassowrdAnimation = Tween<double>(
      begin: Properties.animatedTimeInMiliSecond * 1.0,
      end: 0,
    ).animate(_forgotPassowrdAnimationController)
      ..addListener(() {
        setState(() {});
      });
    _forgotPassowrdAnimationController.value = 1.0;

    _userStore = Provider.of<UserStore>(context, listen: false);
    _searchStore = Provider.of<SearchStore>(context, listen: false);

    _authenStore = Provider.of<AuthenStore>(context, listen: false);

    if (null != _authenStore.userEmailAccount) {
      _userEmailController.text = _authenStore.userEmailAccount!;
      _store.setUserId(_authenStore.userEmailAccount!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: Stack(
        children: <Widget>[
          MediaQuery.of(context).orientation == Orientation.landscape
              ? Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _buildBanner(),
                    ),
                    Expanded(
                      flex: 1,
                      child: _buildContent(),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    _buildBanner(),
                    SafeArea(
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: Dimens.horizontal_margin,
                          ),
                          child: GlassmorphismContainer(
                            blur: Properties.blur_glass_morphism,
                            opacity: Properties.opacity_glass_morphism,
                            padding: const EdgeInsets.symmetric(
                              vertical: Dimens.large_vertical_padding,
                            ),
                            child: _buildContent(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          Observer(
            // validator
            builder: (_) {
              return _authenStore.isSuccess
                  ? _showSuccessMessage(
                      _authenStore.getSuccessMessageKey,
                      duration: Properties.delayTimeInSecond,
                    )
                  : ApplicationUtils.showErrorMessage(
                      context,
                      "credential_notification_title_translate",
                      _authenStore.getFailedMessageKey,
                    );
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _authenStore.isLoading ||
                    _userStore.isLoading ||
                    _searchStore.isLoading,
                child: const CustomProgressIndicatorWidget(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return LinearGradientBackground(
      colors: _themeStore.lineToLineGradientColors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: null,
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.large_horizontal_padding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: Strings.authorizeHeroTag,
              child: AppIconWidget(image: _themeStore.appIcon),
            ),
            const SizedBox(
              height: Dimens.extra_large_vertical_margin,
            ),
            _buildUserIdField(),
            _buildPasswordField(),
            _buildConfirmPasswordField(),
            _buildNameField(),
            const SizedBox(
              height: Dimens.vertical_margin,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSignupinButton(),
                _buildForgotPasswordButton(),
              ],
            ),
            _buildSignButton(),
            _othersWayLogin(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserIdField() {
    return Container(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      height: Dimens.text_field_height,
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('login_et_user_email'),

            inputType: TextInputType.emailAddress,
            iconData: Icons.person,
            textController: _userEmailController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            onChanged: (value) {
              _store.setUserId(_userEmailController.text);
            },
            // onFieldSubmitted: (value) {
            //   FocusScope.of(context).requestFocus(_passwordFocusNode);
            // },
            errorText: _store.formErrorStore.userEmail,
          );
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      height:
          _forgotPassowrdAnimationController.value * Dimens.text_field_height,
      child: _forgotPassowrdAnimationController.value >= 0.3
          ? Opacity(
              opacity: _forgotPassowrdAnimationController.value,
              child: Observer(
                builder: (_) {
                  return TextFieldWidget(
                    hint: AppLocalizations.of(context)
                        .translate('login_et_user_password'),
                    isObscure: true,
                    margin: const EdgeInsets.symmetric(
                      vertical: Dimens.vertical_margin,
                    ),
                    iconData: Icons.lock,
                    textController: _passwordController,
                    focusNode: _passwordFocusNode,
                    errorText: _store.formErrorStore.password,
                    onChanged: (value) {
                      _store.setPassword(_passwordController.text);
                    },
                  );
                },
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Container(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      height: _authenAnimationController.value * Dimens.text_field_height,
      child: _authenAnimationController.value >= 0.3
          ? Opacity(
              opacity: _authenAnimationController.value,
              child: Observer(
                builder: (_) {
                  return TextFieldWidget(
                    hint: AppLocalizations.of(context)
                        .translate('login_reet_user_password'),
                    isObscure: true,
                    margin: const EdgeInsets.only(top: 16.0),
                    iconData: Icons.lock,
                    textController: _confirmPasswordController,
                    errorText: _store.formErrorStore.confirmPassword,
                    onChanged: (value) {
                      _store
                          .setConfirmPassword(_confirmPasswordController.text);
                    },
                  );
                },
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _buildNameField() {
    return Container(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      height: _authenAnimationController.value * Dimens.text_field_height,
      child: _authenAnimationController.value >= 0.3
          ? Opacity(
              opacity: _authenAnimationController.value,
              child: Observer(
                builder: (_) {
                  return TextFieldWidget(
                    hint: AppLocalizations.of(context)
                        .translate('login_et_user_name'),
                    margin: const EdgeInsets.only(top: 16.0),
                    iconData: Icons.badge,
                    textController: _nameController,
                    errorText: _store.formErrorStore.name,
                    onChanged: (value) {
                      _store.setName(_nameController.text);
                    },
                  );
                },
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: FractionalOffset.centerRight,
      child: TextButton(
        child: Text(
          AppLocalizations.of(context).translate('btn_forgot_password'),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        onPressed: () {
          _store.setForgotPassword();

          _authenAnimationController.reverse();
          _forgotPassowrdAnimationController.reverse();
        },
      ),
    );
  }

  Widget _buildSignupinButton() {
    return Align(
      alignment: FractionalOffset.centerLeft,
      child: Observer(
        builder: (_) {
          if (_store.stateAuthen == AuthenState.signin) {
            return TextButton(
              child: Text(
                AppLocalizations.of(context).translate('signup_btn_sign_up'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onPressed: () {
                _store.setSignup();
                _authenAnimationController.forward();
                _forgotPassowrdAnimationController.forward();
              },
            );
          } else {
            return TextButton(
              child: Text(
                AppLocalizations.of(context).translate('login_btn_sign_in'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onPressed: () {
                _store.setSignin();
                _authenAnimationController.reverse();
                _forgotPassowrdAnimationController.forward();
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildSignButton() {
    bool conditional;
    String keyTranslate;

    if (_store.isForgotPasswordState) {
      keyTranslate = 'reset_btn_password';
      //authenStore.  .forgotPassword;
    } else {
      if (_store.stateAuthen == AuthenState.signin) {
        keyTranslate = 'login_btn_sign_in';
      } else {
        keyTranslate = 'signup_btn_sign_up';
      }
    }

    return Align(
      alignment: Alignment.center,
      child: RoundedButtonWidget(
        buttonText: AppLocalizations.of(context).translate(keyTranslate),
        padding: const EdgeInsets.symmetric(
            vertical: Dimens.lightly_vertical_padding,
            horizontal: Dimens.extra_large_horizontal_padding),
        buttonColor: Colors.transparent,
        onPressed: () async {
          if (_store.isForgotPasswordState) {
            conditional = _store.canForgetPassword;
          } else {
            if (_store.stateAuthen == AuthenState.signin) {
              conditional = _store.canLogin;
            } else {
              conditional = _store.canRegister;
            }
          }
          if (conditional) {
            DeviceUtils.hideKeyboard(context);
            if (_store.isForgotPasswordState) {
              // _authenStore.forgotPassword()
            } else {
              if (_store.stateAuthen == AuthenState.signin) {
                _authenStore.login(_store.userEmail, _store.password);
              } else {
                _authenStore.register(
                    _store.userEmail, _store.password, _store.name);
              }
            }
          }
        },
      ),
    );
  }

  Widget _othersWayLogin() {
    return Column(
      children: [
        SmallTextWidget(
          text: AppLocalizations.of(context).translate('login_others_ways'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SGVButton(
              width: 40,
              assetName: Assets.facebookSVGLogo,
              ontap: () {
                FlushbarHelper.createInformation(
                  message: AppLocalizations.of(context)
                      .translate("upcomming_feature_translate"),
                  title:
                      AppLocalizations.of(context).translate('home_tv_infor'),
                  duration:
                      const Duration(seconds: Properties.delayTimeInSecond),
                ).show(context);
              },
            ),
            SGVButton(
              width: 40,
              assetName: Assets.googleSVGLogo,
              ontap: () async {
                await _authenStore.googleAuthenticator();
              },
            ),
          ],
        ),
      ],
    );
  }

  // General Methods:-----------------------------------------------------------

  _showSuccessMessage(String key,
      {int duration = Properties.delayTimeInSecond}) {
    if (key.isNotEmpty) {
      getIt<NotificationStore>().fetchAllNotifications();
      _searchStore.initializeDatabase().then((_) {
        FlushbarHelper.createSuccess(
          message: AppLocalizations.of(context).translate(key),
          title: AppLocalizations.of(context)
              .translate('success_credential_title'),
          duration: Duration(seconds: duration),
        ).show(context).then((_) {
          _userStore.fetchUserInfor().then((isCanRoute) {
            Routes.authenticatedRoute(context);
          });
        });
      });
    }

    return const SizedBox.shrink();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();

    _passwordFocusNode.dispose();

    _authenAnimationController.dispose();
    _forgotPassowrdAnimationController.dispose();

    super.dispose();
  }
}
