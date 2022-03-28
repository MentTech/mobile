import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/assets.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/user/user.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/image_container/user_image_container.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final ThemeStore themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: GestureDetector(
        onTap: DeviceUtils.hideKeyboard(context),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: const AssetImage(
              Assets.settingsBackgroundAssets,
            ),
            fit: BoxFit.fitHeight,
            opacity: themeStore.opacityTheme,
          )),
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.horizontal_padding,
              vertical: Dimens.vertical_padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Observer(
                builder: (_) {
                  UserModel userModel =
                      Provider.of<UserStore>(context, listen: false).user!;

                  return ListTile(
                    onTap: () {
                      // screenRoute(
                      //     context: context,
                      //     routeNamed: Routes.accountManagement);
                    },
                    title: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        AppLocalizations.of(context).translate('greeting'),
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: Dimens.large_text,
                            color: themeStore.textTitleColor),
                      ),
                    ),
                    subtitle: Text(
                      userModel.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: Dimens.extra_large_text,
                          color: themeStore.textTitleColor),
                    ),
                    trailing: userModel.avatar != null
                        ? UserAvatar(url: userModel.avatar!)
                        : const UserAvatar(
                            url:
                                'https://nudeok.com/s/asian/a07/NudeOK.Com-Cute-Girl-Asian-Model-China-Nipple-Ass-Cunt-Pussy-Nude-Sexy%20(95).jpg'),
                  );
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: const <Widget>[
                            // NavigatorButton(
                            //   leadingIcon: Icons.person_outline,
                            //   title: AppLocalizations.of(context)
                            //       .translate("settings_view_feedbacks"),
                            //   onTap: () {
                            //     screenRoute(
                            //         context: context,
                            //         routeNamed: Routes.viewFeedbacks);
                            //   },
                            // ),
                            // NavigatorButton(
                            //   leadingIcon: Icons.list,
                            //   title: AppLocalizations.of(context)
                            //       .translate("settings_booking_history"),
                            //   onTap: () {
                            //     screenRoute(
                            //         context: context,
                            //         routeNamed: Routes.bookingHistory);
                            //   },
                            // ),
                            // NavigatorButton(
                            //   leadingIcon: Icons.history,
                            //   title: AppLocalizations.of(context)
                            //       .translate("settings_session_history"),
                            //   onTap: () {
                            //     screenRoute(
                            //         context: context,
                            //         routeNamed: Routes.sessionHistory);
                            //   },
                            // ),
                            // NavigatorButton(
                            //     leadingIcon: Icons.settings_outlined,
                            //     title: AppLocalizations.of(context)
                            //         .translate("settings_advanced_settings"),
                            //     onTap: () {
                            //       screenRoute(
                            //           context: context,
                            //           routeNamed: Routes.advancedSettings);
                            //     }),
                          ],
                        ),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.symmetric(
                      //       vertical: Dimens.verticalMargin),
                      //   child: Column(
                      //     children: <Widget>[
                      //       NavigatorButton(
                      //         leadingIcon: Icons.cast_for_education_rounded,
                      //         title: AppLocalizations.of(context)
                      //             .translate("settings_courses_e_book"),
                      //         onTap: () {
                      //           screenRoute(
                      //               context: context,
                      //               routeNamed: Routes.coursesEbookView);
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: const EdgeInsets.symmetric(vertical: 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       NavigatorGradientButton(
                      //         leadingIcon: Icons.school_outlined,
                      //         title: AppLocalizations.of(context)
                      //             .translate("settings_become_a_tutor"),
                      //         onTap: () {
                      //           screenRoute(
                      //               context: context,
                      //               routeNamed: Routes.becomeTutor);
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: const EdgeInsets.symmetric(vertical: 10),
                      //   child: Column(
                      //     children: <Widget>[
                      //       NavigatorButton(
                      //         leadingIcon: Icons.language_outlined,
                      //         title: AppLocalizations.of(context)
                      //             .translate("settings_our_website"),
                      //         onTap: () {
                      //           ourWebsiteRoute(context: context);
                      //         },
                      //       ),
                      //       NavigatorButton(
                      //         leadingIcon: Icons.travel_explore_outlined,
                      //         title: AppLocalizations.of(context)
                      //             .translate("settings_fb"),
                      //         onTap: () {
                      //           facebookRoute(context: context);
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            DeviceUtils.packageInfo != null
                                ? RichText(
                                    textAlign: TextAlign.right,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              '${AppLocalizations.of(context).translate("settings_ver")}:  ',
                                          style: const TextStyle(
                                              color: Colors.black)),
                                      TextSpan(
                                          text:
                                              DeviceUtils.packageInfo!.version,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black))
                                    ]),
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: Dimens.vertical_margin,
                            ),
                            // GlassmorphismButton(
                            //   text: AppLocalizations.of(context)
                            //       .translate('logout'),
                            //   blur: Properties.blur_glass_morphism,
                            //   opacity: Properties.opacity_glass_morphism,
                            // ),
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
      ),
    );
  }

  void screenRoute(
      {required BuildContext context, required String routeNamed}) {
    Navigator.of(context).pushNamed(routeNamed);
  }

  void ourWebsiteRoute({required BuildContext context}) {}
  void facebookRoute({required BuildContext context}) {}

  // void logoutRoute({required BuildContext context}) {
  //   // getIt<Repository>().removeAuthTokens();
  //   Provider.of<AuthorizationStore>(context, listen: false).logout();
  //   Navigator.of(context).pushReplacementNamed(Routes.login);
  // }
}
