import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/ui/home/page/notification_page.dart';

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
    Icon(Icons.notifications_active_rounded, size: sizeBottomButton),
    Icon(Icons.settings, size: sizeBottomButton),
  ];

  final List<Widget> pageList = [
    // const SchedulePage(),
    const TutorPage(),
    const HomePage(),
    // MessagePage(),
    NotificationPage(),
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
