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

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  //text controllers:-----------------------------------------------------------
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  late UserStore _userStore;

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  //stores:---------------------------------------------------------------------
  final _store = FormStore();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
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
            builder: (context) {
              return _store.success
                  ? navigate(context)
                  : _showErrorMessage(_store.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _store.loading,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSignupButton(),
                _buildForgotPasswordButton(),
              ],
            ),
            _buildSignInButton(),
            _othersWayLogin(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserIdField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('login_et_user_email'),
          inputType: TextInputType.emailAddress,
          icon: Icons.person,
          iconColor: AppColors.darkTextTheme,
          textController: _userEmailController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _store.setUserId(_userEmailController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _store.formErrorStore.userEmail,
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint:
              AppLocalizations.of(context).translate('login_et_user_password'),
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
        onPressed: () {},
      ),
    );
  }

  Widget _buildSignupButton() {
    return Align(
      alignment: FractionalOffset.centerLeft,
      child: TextButton(
        child: Text(
          AppLocalizations.of(context).translate('signup_btn_sign_up'),
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: AppColors.darkTextTheme),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _buildSignInButton() {
    return RoundedButtonWidget(
      buttonText: AppLocalizations.of(context).translate('login_btn_sign_in'),
      buttonColor: Colors.transparent,
      textColor: AppColors.darkTextTheme,
      onPressed: () async {
        if (_store.canLogin) {
          DeviceUtils.hideKeyboard(context);
          _store.login();
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
              ontap: () {},
            ),
            const SizedBox(width: Dimens.horizontal_padding / 3),
            SGVButton(
              width: 40,
              assetName: Assets.googleSVGLogo,
              ontap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget navigate(BuildContext context) {
    _userStore.login(_store.userEmail, _store.password).then((value) {
      if (value) {
        _userStore.fetchUserInfor().then((value) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.home, (Route<dynamic> route) => false);
        });
      }
    });

    return Container();
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      FlushbarHelper.createError(
        message: message,
        title: AppLocalizations.of(context).translate('home_tv_error'),
        duration: const Duration(seconds: Properties.delayTimeInSecond),
      ).show(context);
    }

    return const SizedBox.shrink();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
