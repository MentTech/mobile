import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';

class CustomInStackAppBar extends StatelessWidget {
  CustomInStackAppBar({Key? key}) : super(key: key);

  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return GlassmorphismContainer(
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Routes.popRoute(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: _themeStore.reverseThemeColor,
              ),
            ),
            Text(
              AppLocalizations.of(context).translate("deposit_title"),
              style: TextStyle(
                fontSize: Dimens.medium_text,
                color: _themeStore.reverseThemeColor,
              ),
            ),
          ],
        ),
      ),
      blur: Properties.blur_glass_morphism,
      opacity: Properties.opacity_glass_morphism,
      radius: Dimens.kBorderRadiusValue,
    );
  }
}
