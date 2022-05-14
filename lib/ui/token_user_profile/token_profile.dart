import 'package:flutter/material.dart';
import 'package:mobile/constants/assets.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/widgets/app_icon_widget.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';

class TokenProfile extends StatelessWidget {
  TokenProfile({Key? key}) : super(key: key);

  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LinearGradientBackground(
            colors: [
              _themeStore.themeColor,
              Colors.black
                  .withGreen((_themeStore.themeColor.green * 0.2).round())
                  .withBlue((_themeStore.themeColor.blue * 0.2).round()),
            ],
            stops: const [0, 0.35],
          ),
          SafeArea(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildHeaderWidget(),
              _buildTopPayedWidget(),
              _buildSessionWidget(),
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildHeaderWidget() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const AppIconWidget(
              dimenImage: Dimens.text_field_height,
              image: Assets.appLogo,
            ),
            Text(
              DeviceUtils.packageInfo!.appName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: Dimens.medium_text,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildTopPayedWidget() {
    return const SizedBox();
  }

  Widget _buildSessionWidget() {
    return const SizedBox();
  }
}
