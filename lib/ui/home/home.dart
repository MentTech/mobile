import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/notification/notification_store.dart';
import 'package:mobile/ui/home/page/next_sessions_page.dart';

import 'page/home_page.dart';
import 'page/next_sessions_page.dart';
import 'page/notification_page.dart';
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
  final pageController = PageController(keepPage: true, initialPage: 2);

  // static value:--------------------------------------------------------------
  static const double sizeBottomButton = 30;

  // final value:---------------------------------------------------------------
  final durationEffect = const Duration(milliseconds: 500);
  final curveEffect = Curves.easeInOutSine;

  final List<Icon> _listCurveButtonIcon = const [
    Icon(Icons.school_rounded, size: sizeBottomButton),
    Icon(Icons.date_range, size: sizeBottomButton),
    Icon(Icons.home, size: sizeBottomButton),
    Icon(Icons.notifications_active_rounded, size: sizeBottomButton),
    Icon(Icons.settings, size: sizeBottomButton),
  ];

  final List<Widget> pageList = [
    const TutorPage(),
    const NextSessionsPage(),
    const HomePage(),
    NotificationPage(),
    SettingsPage(),
  ];

  // state:---------------------------------------------------------------------
  final int _initButtonIndex = 2;

  // init stores:---------------------------------------------------------------

  // general function
  void onBottomChanged(int index) {
    pageController.animateToPage(index,
        duration: durationEffect, curve: curveEffect);
  }

  @override
  void initState() {
    super.initState();

    getIt<NotificationStore>().connectSocket();
  }

  @override
  void dispose() {
    getIt<NotificationStore>().dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          color: Theme.of(context).bottomAppBarColor,
          height: sizeBottomButton * 2,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Theme.of(context).primaryColor,
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
