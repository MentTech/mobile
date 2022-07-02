import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/appbar/custom_appbar_in_stack.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';

class DepositTokenSuccessFul extends StatelessWidget {
  DepositTokenSuccessFul({Key? key}) : super(key: key);

  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          LinearGradientBackground(
            colors: _themeStore.lineToLineGradientColors,
            stops: null,
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.horizontal_padding,
                  vertical: Dimens.vertical_padding),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(
                      height: kBottomNavigationBarHeight,
                    ),
                    _buildLottieSuccessfullyWidget(context),
                    _buildContentToPayup(context),
                  ],
                ),
              ),
            ),
          ),
          CustomInStackAppBar(
            nameAppbar: AppLocalizations.of(context).translate("deposit_title"),
          ),
        ],
      ),
    );
  }

  Widget _buildLottieSuccessfullyWidget(BuildContext context) {
    return Lottie.asset('assets/lottiefiles/success-animation.json',
        height: DeviceUtils.getScaledHeight(context, 0.3));
  }

  Widget _buildContentToPayup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimens.vertical_padding,
        horizontal: Dimens.horizontal_padding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)
                .translate("create_request_to_top_up_title"),
            style: TextStyle(
              color: _themeStore.reverseThemeColor,
              fontSize: Dimens.medium_text,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: Dimens.vertical_margin,
          ),
          Text(
            AppLocalizations.of(context).translate("transfer_infor_message"),
            style: TextStyle(
              color: _themeStore.reverseThemeColor,
              fontSize: Dimens.small_text,
            ),
          ),
          const SizedBox(
            height: Dimens.ultra_extra_large_vertical_margin,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context).translate("phone_number_lable"),
                style: TextStyle(
                  color: _themeStore.reverseThemeColor,
                  fontSize: Dimens.lightly_medium_text,
                ),
              ),
              Text(
                "0123456789",
                style: TextStyle(
                  color: _themeStore.reverseThemeColorfulColor,
                  fontSize: Dimens.lightly_medium_text,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Dimens.lightly_medium_vertical_margin,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context).translate("account_number"),
                style: TextStyle(
                  color: _themeStore.reverseThemeColor,
                  fontSize: Dimens.lightly_medium_text,
                ),
              ),
              Text(
                "123456789",
                style: TextStyle(
                  color: _themeStore.reverseThemeColorfulColor,
                  fontSize: Dimens.lightly_medium_text,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Dimens.lightly_medium_vertical_margin,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context).translate("bank_label"),
                style: TextStyle(
                  color: _themeStore.reverseThemeColor,
                  fontSize: Dimens.lightly_medium_text,
                ),
              ),
              Text(
                "Vietcombank",
                style: TextStyle(
                  color: _themeStore.reverseThemeColorfulColor,
                  fontSize: Dimens.lightly_medium_text,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Dimens.lightly_medium_vertical_margin,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context).translate("account_name"),
                style: TextStyle(
                  color: _themeStore.reverseThemeColor,
                  fontSize: Dimens.lightly_medium_text,
                ),
              ),
              Text(
                "Nguyen Van A",
                style: TextStyle(
                  color: _themeStore.reverseThemeColorfulColor,
                  fontSize: Dimens.lightly_medium_text,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Dimens.lightly_medium_vertical_margin,
          ),
          Text(
            AppLocalizations.of(context).translate("transfer_content"),
            style: TextStyle(
              color: _themeStore.reverseThemeColor,
              fontSize: Dimens.lightly_medium_text,
            ),
          ),
          Text(
            AppLocalizations.of(context).translate("full_name") +
                " - " +
                AppLocalizations.of(context).translate("email") +
                " - " +
                AppLocalizations.of(context).translate("token_deposit_payment"),
            style: TextStyle(
              color: _themeStore.reverseThemeColorfulColor,
              fontSize: Dimens.lightly_medium_text,
            ),
          ),
        ],
      ),
    );
  }
}
