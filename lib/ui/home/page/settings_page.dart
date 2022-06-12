import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/assets.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/user/user.dart';
import 'package:mobile/stores/authen/authen_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:mobile/widgets/container/section_container/linear_named_list_widget.dart';
import 'package:mobile/widgets/container/section_container/wrap_named_list_widget.dart';
import 'package:mobile/widgets/glassmorphism_widgets/glassmorphism_text_button.dart';
import 'package:mobile/widgets/glassmorphism_widgets/glassmorphism_widget_button.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final ThemeStore themeStore = getIt<ThemeStore>();
  final AuthenStore authenStore = getIt<AuthenStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(
            Assets.settingsBackgroundAssets,
          ),
          fit: BoxFit.fitHeight,
          opacity: themeStore.opacityTheme,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.horizontal_padding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SafeArea(
            bottom: false,
            child: Observer(
              builder: (_) {
                UserModel userModel =
                    Provider.of<UserStore>(context, listen: false).user!;

                return ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.profile);
                  },
                  title: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      AppLocalizations.of(context).translate('greeting'),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: Dimens.lightly_medium_text,
                        color: themeStore.reverseThemeColor,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    userModel.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: Dimens.extra_large_text,
                      color: themeStore.reverseThemeColor,
                    ),
                  ),
                  trailing: NetworkImageWidget(
                    url: userModel.avatar,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Observer(
                builder: (_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      WrapNamedListWidget(
                        themeColor: themeStore.reverseThemeColor,
                        namedContainer: "Programs",
                        margin: const EdgeInsets.symmetric(
                          vertical: Dimens.large_vertical_margin,
                        ),
                        children: <Widget>[
                          GlassmorphismWidgetButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.dashboard,
                                  color: themeStore.reverseThemeColor,
                                  size: Dimens.large_text,
                                ),
                                const SizedBox(
                                  height: Dimens.vertical_margin,
                                ),
                                Text(
                                  "Sessions",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: themeStore.reverseThemeColor,
                                      letterSpacing: 0.2,
                                      fontSize: Dimens.small_text),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            width: 100,
                            blur: Properties.blur_glass_morphism,
                            opacity: Properties.opacity_glass_morphism,
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.horizontal_padding,
                              vertical: Dimens.vertical_padding,
                            ),
                            radius: 15,
                            onTap: () {
                              screenRoute(
                                context: context,
                                routeNamed: Routes.tokenProfile,
                              );
                            },
                          ),
                        ],
                      ),
                      LinearNamedListWidget(
                        themeColor: themeStore.reverseThemeColor,
                        namedContainer: "Settings",
                        children: <Widget>[
                          GlassmorphismTextButton(
                            text: "Advanced Settings",
                            textColor: themeStore.reverseThemeColor,
                            blur: Properties.blur_glass_morphism,
                            opacity: Properties.opacity_glass_morphism,
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.horizontal_padding,
                              vertical: Dimens.vertical_padding,
                            ),
                            radius: 15,
                            onTap: () {
                              Routes.navigatorSupporter(
                                  context, Routes.advancedSettings);
                            },
                          ),
                          GlassmorphismTextButton(
                            text: "Change password",
                            textColor: themeStore.reverseThemeColor,
                            blur: Properties.blur_glass_morphism,
                            opacity: Properties.opacity_glass_morphism,
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.horizontal_padding,
                              vertical: Dimens.vertical_padding,
                            ),
                            radius: 15,
                            onTap: () {
                              Routes.navigatorSupporter(
                                  context, Routes.changePasswordSettings);
                            },
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: Dimens.extra_large_vertical_margin,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            DeviceUtils.packageInfo != null
                                ? RichText(
                                    textAlign: TextAlign.right,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                '${AppLocalizations.of(context).translate("settings_ver")}:  ',
                                            style: TextStyle(
                                              color:
                                                  themeStore.reverseThemeColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: Dimens.more_small_text,
                                            )),
                                        TextSpan(
                                            text: DeviceUtils
                                                .packageInfo!.version,
                                            style: TextStyle(
                                              fontSize: Dimens.small_text,
                                              fontWeight: FontWeight.w900,
                                              color:
                                                  themeStore.reverseThemeColor,
                                            ))
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: Dimens.vertical_margin,
                            ),
                            GlassmorphismTextButton(
                              text: AppLocalizations.of(context)
                                  .translate('logout'),
                              textColor: themeStore.reverseThemeColor,
                              blur: Properties.blur_glass_morphism,
                              opacity: Properties.opacity_glass_morphism,
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.horizontal_padding,
                                vertical: Dimens.vertical_padding,
                              ),
                              radius: 15,
                              onTap: () {
                                authenStore.logout().then((_) {
                                  Routes.unauthenticatedRoute(context);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: kBottomNavigationBarHeight,
                      )
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void screenRoute(
      {required BuildContext context, required String routeNamed}) {
    Navigator.of(context).pushNamed(routeNamed);
  }
}
