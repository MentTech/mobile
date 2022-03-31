import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/assets.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/constants/strings.dart';
import 'package:mobile/stores/form/form_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/app_icon_widget.dart';
import 'package:mobile/widgets/button_widgets/sgv_button_widget.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/progress_indicator_widget.dart';
import 'package:mobile/widgets/button_widgets/rounded_button_widget.dart';
import 'package:mobile/widgets/text_widget.dart';
import 'package:mobile/widgets/textfield_widget.dart';
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

  //focus node:-----------------------------------------------------------------
  final FocusNode _passwordFocusNode = FocusNode();

  //stores:---------------------------------------------------------------------
  final _store = FormStore();

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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore = Provider.of<UserStore>(context, listen: false);
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
                      child: GlassmorphismContainer(
                        blur: Properties.blur_glass_morphism,
                        opacity: Properties.opacity_glass_morphism,
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimens.vertical_padding * 2),
                        child: _buildContent(),
                      ),
                    )),
                  ],
                ),
          Observer(
            // validator
            builder: (_) {
              return _store.success
                  ? _showSuccessMessage(_store.messageStore.successMessage,
                      duration: Properties.delayTimeInSecond)
                  : _showErrorMessage(_store.messageStore.errorMessage,
                      duration: Properties.delayTimeInSecond);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _store.loading || _userStore.isLoading,
                child: const CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.firstGradientBackgroundTheme,
              AppColors.secondGradientBackgroundTheme,
              AppColors.firstGradientBackgroundTheme,
            ],
          ),
          // Image.asset(
          //   Assets.loginBackground,
          //   fit: BoxFit.cover,
          // ),
        ),
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
                child: AppIconWidget(image: 'assets/icons/ic_appicon.png')),
            const SizedBox(height: Dimens.horizontal_padding * 2),
            _buildUserIdField(),
            _buildPasswordField(),
            _buildConfirmPasswordField(),
            _buildNameField(),
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
      alignment: Alignment.center,
      height: Dimens.text_field_height,
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('login_et_user_email'),
            inputType: TextInputType.emailAddress,
            icon: Icons.person,
            iconColor: AppColors.darkTextTheme,
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
                    padding: const EdgeInsets.only(top: 16.0),
                    icon: Icons.lock,
                    iconColor: AppColors.darkTextTheme,
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
                    padding: const EdgeInsets.only(top: 16.0),
                    icon: Icons.lock,
                    iconColor: AppColors.darkTextTheme,
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
                    padding: const EdgeInsets.only(top: 16.0),
                    icon: Icons.badge,
                    iconColor: AppColors.darkTextTheme,
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
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: AppColors.darkTextTheme),
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
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: AppColors.darkTextTheme),
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
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: AppColors.darkTextTheme),
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
    Future<dynamic> Function() signFunction;

    if (_store.isForgotPasswordState) {
      keyTranslate = 'reset_btn_password';
      signFunction = _store.forgotPassword;
    } else {
      if (_store.stateAuthen == AuthenState.signin) {
        keyTranslate = 'login_btn_sign_in';
        signFunction = _store.login;
      } else {
        keyTranslate = 'signup_btn_sign_up';
        signFunction = _store.register;
      }
    }

    return RoundedButtonWidget(
      buttonText: AppLocalizations.of(context).translate(keyTranslate),
      buttonColor: Colors.transparent,
      textColor: AppColors.darkTextTheme,
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
          signFunction();
        } else {
          _showErrorMessage('Please fill in all fields');
        }
      },
    );
  }

  Widget _othersWayLogin() {
    return Column(
      children: [
        TextWidget(
          text: AppLocalizations.of(context).translate('login_others_ways'),
          textColor: AppColors.darkTextTheme,
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
                  message: "This feature will be in next update.",
                  title:
                      AppLocalizations.of(context).translate('home_tv_infor'),
                  duration:
                      const Duration(seconds: Properties.delayTimeInSecond),
                ).show(context);
              },
            ),
            const SizedBox(width: Dimens.horizontal_padding / 3),
            SGVButton(
              width: 40,
              assetName: Assets.googleSVGLogo,
              ontap: () async {
                _store.googleAuthenticator();
              },
            ),
          ],
        ),
      ],
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message,
      {int duration = Properties.delayTimeInSecond}) {
    if (message.isNotEmpty) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: duration),
        ).show(context);
      });
    }

    return const SizedBox.shrink();
  }

  _showSuccessMessage(String message,
      {int duration = Properties.delayTimeInSecond}) {
    if (message.isNotEmpty) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        FlushbarHelper.createSuccess(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_success'),
          duration: Duration(seconds: duration),
        ).show(context).then((_) {
          if (_store.logined) {
            _userStore.fetchUserInfor().then((_) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.home, (Route<dynamic> route) => false);
            });
          }
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
