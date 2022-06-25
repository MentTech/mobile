import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:mobile/widgets/container/section_container/linear_named_list_widget.dart';
import 'package:mobile/widgets/glassmorphism_widgets/glassmorphism_text_button.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final ThemeStore themeStore = getIt<ThemeStore>();
  final AuthenStore authenStore = getIt<AuthenStore>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Observer(builder: (_) {
          return LinearGradientBackground(
            colors: themeStore.lineToLineGradientColors,
            stops: null,
          );
        }),
        Padding(
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
                          const SizedBox(
                            height: Dimens.ultra_extra_large_vertical_margin,
                          ),
                          LinearNamedListWidget(
                            themeColor: themeStore.reverseThemeColor,
                            namedContainer: AppLocalizations.of(context)
                                .translate("account_settings_translate"),
                            children: <Widget>[
                              GlassmorphismTextButton(
                                text: AppLocalizations.of(context)
                                    .translate("change_password_translate"),
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
                              GlassmorphismTextButton(
                                text: AppLocalizations.of(context)
                                    .translate("transaction_history"),
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
                          const SizedBox(
                            height: Dimens.vertical_margin,
                          ),
                          LinearNamedListWidget(
                            themeColor: themeStore.reverseThemeColor,
                            namedContainer: AppLocalizations.of(context)
                                .translate("application_translate"),
                            children: <Widget>[
                              GlassmorphismTextButton(
                                text: AppLocalizations.of(context)
                                    .translate("advanced_settings_translate"),
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
                              // GlassmorphismTextButton(
                              //   text: "text ui",
                              //   textColor: themeStore.reverseThemeColor,
                              //   blur: Properties.blur_glass_morphism,
                              //   opacity: Properties.opacity_glass_morphism,
                              //   padding: const EdgeInsets.symmetric(
                              //     horizontal: Dimens.horizontal_padding,
                              //     vertical: Dimens.vertical_padding,
                              //   ),
                              //   radius: 15,
                              //   onTap: () {
                              //     Routes.navigatorSupporter(
                              //         context, Routes.testScreen);
                              //   },
                              // ),
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
                                                  color: themeStore
                                                      .reverseThemeColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      Dimens.more_small_text,
                                                )),
                                            TextSpan(
                                                text: DeviceUtils
                                                    .packageInfo!.version,
                                                style: TextStyle(
                                                  fontSize: Dimens.small_text,
                                                  fontWeight: FontWeight.w900,
                                                  color: themeStore
                                                      .reverseThemeColor,
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
        ),
      ],
    );
  }

  void screenRoute(
      {required BuildContext context, required String routeNamed}) {
    Navigator.of(context).pushNamed(routeNamed);
  }
}
