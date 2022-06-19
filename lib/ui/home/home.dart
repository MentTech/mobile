import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/theme/theme_store.dart';

import 'page/home_page.dart';
import 'page/settings_page.dart';
import 'page/tutor_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // key:-----------------------------------------------------------------------
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
      GlobalKey<CurvedNavigationBarState>();

  // controller:----------------------------------------------------------------
  final pageController = PageController(keepPage: true, initialPage: 1);

  // static value:--------------------------------------------------------------
  static const double sizeBottomButton = 30;

  // final value:---------------------------------------------------------------
  final durationEffect = const Duration(milliseconds: 500);
  final curveEffect = Curves.easeInOutSine;

  final List<Icon> _listCurveButtonIcon = const [
    // Icon(Icons.date_range, size: _sizeBottomButton),
    Icon(Icons.school_rounded, size: sizeBottomButton),
    Icon(Icons.home, size: sizeBottomButton),
    // Icon(Icons.forum, size: _sizeBottomButton),
    Icon(Icons.settings, size: sizeBottomButton),
  ];

  final List<Widget> pageList = [
    // const SchedulePage(),
    const TutorPage(),
    const HomePage(),
    // MessagePage(),
    SettingsPage(),
  ];

  // state:---------------------------------------------------------------------
  final int _initButtonIndex = 1;

  // init stores:---------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();

  // general function
  void onBottomChanged(int index) {
    pageController.animateToPage(index,
        duration: durationEffect, curve: curveEffect);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _themeStore.themeColor,
      extendBody: true,
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          color: Theme.of(context).primaryColor,
          height: sizeBottomButton * 2,
          backgroundColor: Colors.transparent,
          index: _initButtonIndex,
          animationCurve: curveEffect,
          animationDuration: durationEffect,
          items: _listCurveButtonIcon,
          onTap: onBottomChanged,
        ),
      ),
      body: PageView(
        children: pageList,
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   //stores:---------------------------------------------------------------------
//   late ThemeStore _themeStore;
//   // late LanguageStore _languageStore;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     // initializing stores
//     // _languageStore = Provider.of<LanguageStore>(context);
//     _themeStore = Provider.of<ThemeStore>(context);

//     // check to see if already called api
//     // if (!_postStore.loading) {
//     //   _postStore.getPosts();
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: _buildBody(),
//     );
//   }

//   // app bar methods:-----------------------------------------------------------
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       actions: _buildActions(context),
//     );
//   }

//   List<Widget> _buildActions(BuildContext context) {
//     return <Widget>[
//       _buildLanguageButton(),
//       _buildThemeButton(),
//       _buildLogoutButton(),
//     ];
//   }

//   Widget _buildThemeButton() {
//     return Observer(
//       builder: (context) {
//         return IconButton(
//           onPressed: () {
//             _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
//           },
//           icon: Icon(
//             _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildLogoutButton() {
//     return IconButton(
//       onPressed: () {
//         SharedPreferences.getInstance().then((preference) {
//           // preference.setBool(Preferences.is_logged_in, false);
//           Provider.of<AuthenStore>(context, listen: false).logout();
//           Navigator.of(context).pushReplacementNamed(Routes.login);
//         });
//       },
//       icon: const Icon(
//         Icons.power_settings_new,
//       ),
//     );
//   }

//   Widget _buildLanguageButton() {
//     return IconButton(
//       onPressed: () {
//         // _buildLanguageDialog();
//       },
//       icon: const Icon(
//         Icons.language,
//       ),
//     );
//   }

//   // body methods:--------------------------------------------------------------
//   Widget _buildBody() {
//     return Stack(
//       children: const <Widget>[
//         // _handleErrorMessage(),
//         // _buildMainContent(),
//       ],
//     );
//   }

//   // Widget _buildMainContent() {
//   //   return Observer(
//   //     builder: (context) {
//   //       return _postStore.loading
//   //           ? CustomProgressIndicatorWidget()
//   //           : Material(child: _buildListView());
//   //     },
//   //   );
//   // }

//   // Widget _buildListView() {
//   //   return _postStore.postList != null
//   //       ? ListView.separated(
//   //           itemCount: _postStore.postList!.posts!.length,
//   //           separatorBuilder: (context, position) {
//   //             return const Divider();
//   //           },
//   //           itemBuilder: (context, position) {
//   //             return _buildListItem(position);
//   //           },
//   //         )
//   //       : Center(
//   //           child: Text(
//   //             AppLocalizations.of(context).translate('home_tv_no_post_found'),
//   //           ),
//   //         );
//   // }

//   // Widget _buildListItem(int position) {
//   //   return ListTile(
//   //     dense: true,
//   //     leading: const Icon(Icons.cloud_circle),
//   //     title: Text(
//   //       '${_postStore.postList?.posts?[position].title}',
//   //       maxLines: 1,
//   //       overflow: TextOverflow.ellipsis,
//   //       softWrap: false,
//   //       style: Theme.of(context).textTheme.bodyText1,
//   //     ),
//   //     subtitle: Text(
//   //       '${_postStore.postList?.posts?[position].body}',
//   //       maxLines: 1,
//   //       overflow: TextOverflow.ellipsis,
//   //       softWrap: false,
//   //     ),
//   //   );
//   // }

//   // Widget _handleErrorMessage() {
//   //   return Observer(
//   //     builder: (context) {
//   //       if (_postStore.messageStore.errorMessage.isNotEmpty) {
//   //         return _showErrorMessage(_postStore.messageStore.errorMessage);
//   //       }

//   //       return const SizedBox.shrink();
//   //     },
//   //   );
//   // }

//   // General Methods:-----------------------------------------------------------
//   // _showErrorMessage(String message) {
//   //   Future.delayed(const Duration(milliseconds: 0), () {
//   //     if (message.isNotEmpty) {
//   //       FlushbarHelper.createError(
//   //         message: message,
//   //         title: AppLocalizations.of(context).translate('home_tv_error'),
//   //         duration: const Duration(seconds: 3),
//   //       ).show(context);
//   //     }
//   //   });

//   //   return const SizedBox.shrink();
//   // }

//   // _buildLanguageDialog() {
//   //   _showDialog<String>(
//   //     context: context,
//   //     child: MaterialDialog(
//   //       borderRadius: 5.0,
//   //       enableFullWidth: true,
//   //       title: Text(
//   //         AppLocalizations.of(context).translate('home_tv_choose_language'),
//   //         style: const TextStyle(
//   //           color: Colors.white,
//   //           fontSize: 16.0,
//   //         ),
//   //       ),
//   //       headerColor: Theme.of(context).primaryColor,
//   //       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//   //       closeButtonColor: Colors.white,
//   //       enableCloseButton: true,
//   //       enableBackButton: false,
//   //       onCloseButtonClicked: () {
//   //         Navigator.of(context).pop();
//   //       },
//   //       children: _languageStore.supportedLanguages
//   //           .map(
//   //             (object) => ListTile(
//   //               dense: true,
//   //               contentPadding: const EdgeInsets.all(0.0),
//   //               title: Text(
//   //                 object.language!,
//   //                 style: TextStyle(
//   //                   color: _languageStore.locale == object.locale
//   //                       ? Theme.of(context).primaryColor
//   //                       : _themeStore.darkMode
//   //                           ? Colors.white
//   //                           : Colors.black,
//   //                 ),
//   //               ),
//   //               onTap: () {
//   //                 Navigator.of(context).pop();
//   //                 // change user language based on selected locale
//   //                 _languageStore.changeLanguage(object.locale!);
//   //               },
//   //             ),
//   //           )
//   //           .toList(),
//   //     ),
//   //   );
//   // }

//   // _showDialog<T>({required BuildContext context, required Widget child}) {
//   //   showDialog<T>(
//   //     context: context,
//   //     builder: (BuildContext context) => child,
//   //   ).then<void>((T? value) {
//   //     // The value passed to Navigator.pop() or null.
//   //   });
//   // }
// }
