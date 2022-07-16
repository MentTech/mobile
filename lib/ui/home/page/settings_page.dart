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
import 'package:mobile/widgets/app_icon_widget.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:mobile/widgets/container/section_container/linear_named_list_widget.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/glassmorphism_widgets/glassmorphism_text_button.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Observer(builder: (_) {
          return LinearGradientBackground(
            colors: _themeStore.lineToLineGradientColors,
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      subtitle: Text(
                        userModel.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w800),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: Dimens.ultra_extra_large_vertical_margin,
                      ),
                      LinearNamedListWidget(
                        themeColor: Theme.of(context).indicatorColor,
                        namedContainer: AppLocalizations.of(context)
                            .translate("account_settings_translate"),
                        children: <Widget>[
                          GlassmorphismTextButton(
                            text: AppLocalizations.of(context)
                                .translate("change_password_translate"),
                            textColor: Theme.of(context).indicatorColor,
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
                          const SizedBox(height: Dimens.small_vertical_margin),
                          GlassmorphismTextButton(
                            text: AppLocalizations.of(context)
                                .translate("transaction_deal"),
                            textColor: Theme.of(context).indicatorColor,
                            blur: Properties.blur_glass_morphism,
                            opacity: Properties.opacity_glass_morphism,
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.horizontal_padding,
                              vertical: Dimens.vertical_padding,
                            ),
                            radius: 15,
                            onTap: () {
                              Routes.navigatorSupporter(
                                  context, Routes.depositToken);
                            },
                          ),
                          // const SizedBox(height: Dimens.small_vertical_margin),
                          // GlassmorphismTextButton(
                          //   text: AppLocalizations.of(context)
                          //       .translate("order_history_title_translate"),
                          //   textColor: Theme.of(context).indicatorColor,
                          //   blur: Properties.blur_glass_morphism,
                          //   opacity: Properties.opacity_glass_morphism,
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: Dimens.horizontal_padding,
                          //     vertical: Dimens.vertical_padding,
                          //   ),
                          //   radius: 15,
                          //   onTap: () {
                          //     // Routes.navigatorSupporter(
                          //     //     context, Routes.depositToken);
                          //   },
                          // ),
                          const SizedBox(height: Dimens.small_vertical_margin),
                          GlassmorphismTextButton(
                            text: AppLocalizations.of(context)
                                .translate("giftcode_title_translate"),
                            textColor: Theme.of(context).indicatorColor,
                            blur: Properties.blur_glass_morphism,
                            opacity: Properties.opacity_glass_morphism,
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.horizontal_padding,
                              vertical: Dimens.vertical_padding,
                            ),
                            radius: 15,
                            onTap: () {
                              Routes.navigatorSupporter(
                                context,
                                Routes.applyGiftcode,
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimens.large_vertical_margin,
                      ),
                      LinearNamedListWidget(
                        themeColor: Theme.of(context).indicatorColor,
                        namedContainer: AppLocalizations.of(context)
                            .translate("application_translate"),
                        children: <Widget>[
                          GlassmorphismTextButton(
                            text: AppLocalizations.of(context)
                                .translate("advanced_settings_translate"),
                            textColor: Theme.of(context).indicatorColor,
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
                          const SizedBox(height: Dimens.small_vertical_margin),
                          GlassmorphismContainer(
                            alignmentGeometry: Alignment.centerLeft,
                            padding: EdgeInsets.zero,
                            child: AboutListTile(
                              dense: true,
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("about_us"),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.2,
                                    ),
                              ),
                              applicationIcon: AppIconWidget(
                                  image: _themeStore.appIcon,
                                  dimenImage:
                                      DeviceUtils.getScaledWidth(context, 0.1)),
                              applicationName: DeviceUtils.packageInfo!.appName,
                              applicationVersion:
                                  DeviceUtils.packageInfo!.version,
                              applicationLegalese: "Copyright by Jett",
                              aboutBoxChildren: [
                                const SizedBox(
                                  height: Dimens.vertical_margin,
                                ),
                                Text(
                                  "Ứng dụng thuộc Thực tập đồ án tốt nghiệp",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        height: 1.2,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                Text(
                                  "Hệ thống kết nối người hướng dẫn và người cần dạy kèm",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        height: 1.2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(
                                  height: Dimens.vertical_margin,
                                ),
                                Text(
                                  "Nhóm gồm 4 thành viên:",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        height: 1.2,
                                      ),
                                ),
                                Text(
                                  "Nguyễn Điền Thanh Phong - 18120221",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        height: 1.2,
                                      ),
                                ),
                                Text(
                                  "Vũ Lê Tuấn - 18120256",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        height: 1.2,
                                      ),
                                ),
                                Text(
                                  "Lê Quốc Đạt - 18120305",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        height: 1.2,
                                      ),
                                ),
                                Text(
                                  "Lê Thọ Đạt - 18120306",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        height: 1.2,
                                      ),
                                ),
                              ],
                            ),
                            blur: Properties.blur_glass_morphism,
                            opacity: Properties.opacity_glass_morphism,
                            radius: 15,
                          ),
                          // GlassmorphismTextButton(
                          //   text: "test ui",
                          //   textColor: _themeStore.reverseThemeColor,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        TextSpan(
                                          text:
                                              DeviceUtils.packageInfo!.version,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w800),
                                        ),
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
                              textColor: Theme.of(context).indicatorColor,
                              blur: Properties.blur_glass_morphism,
                              opacity: Properties.opacity_glass_morphism,
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.horizontal_padding,
                                vertical: Dimens.vertical_padding,
                              ),
                              radius: 15,
                              onTap: () {
                                Provider.of<AuthenStore>(context, listen: false)
                                    .logout()
                                    .then((_) {
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
