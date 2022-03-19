import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/utils/device/device_utils.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: GestureDetector(
        onTap: DeviceUtils.hideKeyboard(context),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.horizontal_padding,
              vertical: Dimens.vertical_padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Text(
              //   AppLocalizations.of(context).translate("settings_title"),
              //   style: TextStyle(
              //     fontFamily: FontFamily.gilroy,
              //     fontSize: Dimens.largeText,
              //     color: Theme.of(context).primaryColor,
              //     letterSpacing: 2,
              //   ),
              // ),
              // const SizedBox(
              //   height: Dimens.verticalMargin,
              // ),
              // Observer(
              //   builder: (_) {
              //     UserInfo userInfor =
              //         Provider.of<AuthorizationStore>(context, listen: false)
              //             .user!;

              //     return ListTile(
              //       onTap: () {
              //         screenRoute(
              //             context: context,
              //             routeNamed: Routes.accountManagement);
              //       },
              //       leading: UserAvatar(url: userInfor.avatar),
              //       title: Container(
              //         margin: const EdgeInsets.symmetric(vertical: 5),
              //         child: Text(
              //           userInfor.name,
              //           style: const TextStyle(
              //               fontWeight: FontWeight.w800,
              //               fontSize: 18,
              //               color: AppColors.primaryColor),
              //         ),
              //       ),
              //       subtitle: Text(
              //         userInfor.email,
              //         style: const TextStyle(color: AppColors.primaryColor),
              //       ),
              //     );
              //   },
              // ),
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
                          children: const <Widget>[
                            // RichText(
                            //   textAlign: TextAlign.right,
                            //   text: TextSpan(children: [
                            //     TextSpan(
                            //         text:
                            //             '${AppLocalizations.of(context).translate("settings_ver")}:  ',
                            //         style:
                            //             const TextStyle(color: Colors.black)),
                            //     TextSpan(
                            //         text: AppUtils().version,
                            //         style: const TextStyle(
                            //             fontWeight: FontWeight.w900,
                            //             color: Colors.black))
                            //   ]),
                            // ),
                            // const SizedBox(
                            //   height: Dimens.verticalMargin,
                            // ),
                            // MyTextButton(
                            //   text: AppLocalizations.of(context)
                            //       .translate("log_out"),
                            //   fillColor: AppColors.primaryColor,
                            //   fontSizeText: 15,
                            //   textColor: Colors.white,
                            //   onTap: () {
                            //     logoutRoute(context: context);
                            //   },
                            // )
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
