import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  // late ScheduleStore scheduleStore;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  late final List<Tab> _tab;

  late final TabBar _tabBar;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // scheduleStore = Provider.of<ScheduleStore>(context);

    _tab = [
      Tab(text: AppLocalizations.of(context).translate("calendar_translate")),
      Tab(text: AppLocalizations.of(context).translate("list_translate")),
    ];

    _tabBar = TabBar(
      tabs: _tab,
      // padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
      indicator: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: Dimens.kMaxBorderRadius,
      ),
      unselectedLabelColor: Colors.black54,
      labelStyle: Theme.of(context).textTheme.bodyMedium,
      isScrollable: true,
    );
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tab.length,
        child: Column(
          children: [
            Container(
              color: Colors.red,
              child: GlassmorphismContainer(
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    SafeArea(
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('next_sessions_title_translate'),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    // PreferredSize(
                    //   preferredSize: _tabBar.preferredSize,
                    //   child: Container(
                    //     padding: const EdgeInsets.all(4),
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey.shade600,
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //     child: _tabBar,
                    //   ),
                    // ),
                  ],
                ),
                blur: Properties.blur_glass_morphism,
                opacity: Properties.opacity_glass_morphism,
              ),
            ),
            // Expanded(
            //   child: TabBarView(
            //     children: [
            //       _buildCalendarTabView(context),
            //       _buildGroupListTabView(context),
            //     ],
            //   ),
            // ),
          ],
        ));

    // Container(
    //   padding: const EdgeInsets.symmetric(
    //       horizontal: Dimens.horizontal_padding,
    //       vertical: Dimens.vertical_padding),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: <Widget>[
    //       // Text(
    //       //   AppLocalizations.of(context).translate("upcoming_title"),
    //       //   style: TextStyle(
    //       //     fontFamily: FontFamily.gilroy,
    //       //     fontSize: Dimens.large_text,
    //       //     color: Theme.of(context).primaryColor.withAlpha(200),
    //       //     letterSpacing: 2,
    //       //   ),
    //       // ),
    //       // const SizedBox(
    //       //   height: 10,
    //       // ),
    //       Expanded(
    //         child: Observer(
    //           builder: (_) {
    //             return Container();
    //             // SmartRefresher(
    //             //     controller: refreshController,
    //             //     enablePullUp: true,
    //             //     enablePullDown: true,
    //             //     header: FetchMethodWidget.fetchHeaderStatus(context),
    //             //     footer: FetchMethodWidget.fetchFooterStatus(),
    //             //     onRefresh: () async {
    //             //       if (curPage > 1) {
    //             //         curPage--;
    //             //       }
    //             //       await scheduleStore
    //             //           .fetchUpcomingSchedule(page: curPage)
    //             //           .then(
    //             //               (value) => refreshController.refreshCompleted());
    //             //     },
    //             //     onLoading: () async {
    //             //       await scheduleStore
    //             //           .fetchUpcomingSchedule(page: curPage)
    //             //           .then((value) {
    //             //         if (value) {
    //             //           curPage++;
    //             //         }
    //             //         refreshController.loadComplete();
    //             //       });
    //             //     },
    //             //     child: ListView.builder(
    //             //       itemBuilder: (context, index) {
    //             //         return _buildItem(context,
    //             //             scheduleStore.upcomingScheduleList![index]);
    //             //       },
    //             //       itemCount:
    //             //           scheduleStore.upcomingScheduleList?.length ?? 0,
    //             //     ));
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget _buildGroupListTabView(BuildContext context) {
    return SingleChildScrollView(
      child: Container(),

      // Padding(
      //   padding: const EdgeInsets.symmetric(
      //       horizontal: 30 * _scaleScreen, vertical: 20 * _scaleScreen),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Container(
      //         padding: const EdgeInsets.symmetric(
      //             horizontal: 16 * _scaleScreen, vertical: 16 * _scaleScreen),
      //         width: double.infinity,
      //         decoration: BoxDecoration(
      //           color: Theme.of(context).indicatorColor,
      //           borderRadius: Dimens.kBorderRadius,
      //         ),
      //         child: Column(
      //           children: [
      //             Container(
      //               decoration: const BoxDecoration(
      //                 color: Colors.white70,
      //                 borderRadius: BorderRadius.only(
      //                   topLeft: Radius.circular(15),
      //                   topRight: Radius.circular(15),
      //                 ),
      //               ),
      //               padding: const EdgeInsets.symmetric(
      //                   horizontal: 16 * _scaleScreen,
      //                   vertical: 16 * _scaleScreen),
      //               margin: const EdgeInsets.only(bottom: 8 * _scaleScreen),
      //               child: Row(
      //                 children: [
      //                   Expanded(
      //                       child: Column(
      //                     children: [
      //                       Image.asset('assets/eat.png'),
      //                       Text(
      //                         '860',
      //                         style: Theme.of(context)
      //                             .textTheme
      //                             .bodySmall!
      //                             .copyWith(
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: 18,
      //                             ),
      //                       ),
      //                       Text(
      //                         'Ate',
      //                         style: Theme.of(context).textTheme.bodySmall,
      //                       ),
      //                     ],
      //                   )),
      //                   CircularPercentIndicator(
      //                     radius: 100,
      //                     lineWidth: 15,
      //                     animation: true,
      //                     percent: 0.7,
      //                     center: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         Text(
      //                           "1625",
      //                           style: Theme.of(context).textTheme.bodySmall,
      //                         ),
      //                         Text(
      //                           "kCal Left",
      //                           style: Theme.of(context).textTheme.bodySmall,
      //                         ),
      //                       ],
      //                     ),
      //                     backgroundColor: const Color(0xffebebeb),
      //                     circularStrokeCap: CircularStrokeCap.round,
      //                     progressColor: Theme.of(context).primaryColor,
      //                     animationDuration: 1000,
      //                   ),
      //                   Expanded(
      //                       child: Column(
      //                     children: [
      //                       Image.asset('assets/calo.png'),
      //                       Text(
      //                         '120',
      //                         style: Theme.of(context).textTheme.bodySmall,
      //                       ),
      //                       Text(
      //                         'Ate',
      //                         style: Theme.of(context).textTheme.bodySmall,
      //                       ),
      //                     ],
      //                   )),
      //                 ],
      //               ),
      //             ),
      //             Container(
      //               decoration: const BoxDecoration(
      //                 color: Colors.white,
      //                 borderRadius: BorderRadius.only(
      //                   bottomRight: Radius.circular(15),
      //                   bottomLeft: Radius.circular(15),
      //                 ),
      //               ),
      //               padding: const EdgeInsets.symmetric(
      //                   vertical: 10 * _scaleScreen, horizontal: 16),
      //               child: Row(
      //                 children: [
      //                   Expanded(
      //                     child: Padding(
      //                       padding: const EdgeInsets.symmetric(horizontal: 8),
      //                       child: Column(
      //                         children: [
      //                           Text(
      //                             'Carb',
      //                             style: Theme.of(context).textTheme.bodySmall,
      //                           ),
      //                           Padding(
      //                             padding: const EdgeInsets.symmetric(
      //                                 vertical: 4 * _scaleScreen),
      //                             child: LinearProgressIndicator(
      //                               backgroundColor: Colors.grey,
      //                               color: Theme.of(context).primaryColor,
      //                               value: 46 / 158,
      //                             ),
      //                           ),
      //                           Text(
      //                             '46 / 158',
      //                             style: Theme.of(context).textTheme.bodySmall,
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                   Expanded(
      //                     child: Padding(
      //                       padding: const EdgeInsets.symmetric(horizontal: 16),
      //                       child: Column(
      //                         children: [
      //                           Text(
      //                             'Protein',
      //                             style: Theme.of(context).textTheme.bodySmall,
      //                           ),
      //                           Padding(
      //                             padding: const EdgeInsets.symmetric(
      //                                 vertical: 4 * _scaleScreen),
      //                             child: LinearProgressIndicator(
      //                               backgroundColor: Colors.grey,
      //                               color: Theme.of(context).primaryColor,
      //                               value: 46 / 158,
      //                             ),
      //                           ),
      //                           Text(
      //                             '46 / 158',
      //                             style: Theme.of(context).textTheme.bodySmall,
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                   Expanded(
      //                     child: Padding(
      //                       padding: const EdgeInsets.symmetric(horizontal: 8),
      //                       child: Column(
      //                         children: [
      //                           Text(
      //                             'Fat',
      //                             style: Theme.of(context).textTheme.bodySmall,
      //                           ),
      //                           Padding(
      //                             padding: const EdgeInsets.symmetric(
      //                                 vertical: 4 * _scaleScreen),
      //                             child: LinearProgressIndicator(
      //                               backgroundColor: Colors.grey,
      //                               color: Theme.of(context).primaryColor,
      //                               value: 46 / 158,
      //                             ),
      //                           ),
      //                           Text(
      //                             '46 / 158',
      //                             style: Theme.of(context).textTheme.bodySmall,
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 8 * _scaleScreen),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text(
      //               'Your food log',
      //               style: Theme.of(context).textTheme.bodySmall,
      //             ),
      //             ElevatedButton(
      //               onPressed: () {},
      //               child: Row(
      //                 children: [
      //                   Icon(
      //                     Icons.add_circle,
      //                     size: 16 * _scaleScreen,
      //                     color: Theme.of(context).indicatorColor,
      //                   ),
      //                   Text('Meal',
      //                       style: Theme.of(context).textTheme.bodySmall)
      //                 ],
      //               ),
      //               style: ElevatedButton.styleFrom(
      //                 elevation: 0,
      //                 shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(10)),
      //                 primary: Colors.grey.withOpacity(0.5),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.symmetric(vertical: 6 * _scaleScreen),
      //         padding: const EdgeInsets.symmetric(
      //             vertical: 12 * _scaleScreen, horizontal: 16 * _scaleScreen),
      //         decoration: BoxDecoration(
      //           borderRadius: Dimens.kBorderRadius,
      //           color: Colors.white,
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.grey.withOpacity(0.5),
      //               spreadRadius: 2,
      //               blurRadius: 5,
      //               offset: const Offset(0, 2), // changes position of shadow
      //             ),
      //           ],
      //         ),
      //         child: Column(
      //           children: [
      //             ListTile(
      //               leading: Image.asset("assets/breakfast.png"),
      //               title: Text(
      //                 'Breakfast',
      //                 style: Theme.of(context).textTheme.bodySmall,
      //               ),
      //               contentPadding: EdgeInsets.zero,
      //               trailing: IconButton(
      //                 onPressed: () {},
      //                 icon: Icon(
      //                   Icons.add_circle,
      //                   color: Theme.of(context).primaryColor,
      //                   size: 30 * _scaleScreen,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.symmetric(vertical: 6 * _scaleScreen),
      //         padding: const EdgeInsets.symmetric(
      //             vertical: 12 * _scaleScreen, horizontal: 16 * _scaleScreen),
      //         decoration: BoxDecoration(
      //           borderRadius: Dimens.kBorderRadius,
      //           color: Colors.white,
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.grey.withOpacity(0.5),
      //               spreadRadius: 2,
      //               blurRadius: 5,
      //               offset: const Offset(0, 2), // changes position of shadow
      //             ),
      //           ],
      //         ),
      //         child: Column(
      //           children: [
      //             ListTile(
      //               leading: Image.asset("assets/lunch.png"),
      //               title: Text(
      //                 'Lunch',
      //                 style: Theme.of(context).textTheme.bodySmall,
      //               ),
      //               contentPadding: EdgeInsets.zero,
      //               trailing: IconButton(
      //                 onPressed: () {},
      //                 icon: Icon(
      //                   Icons.add_circle,
      //                   color: Theme.of(context).primaryColor,
      //                   size: 30 * _scaleScreen,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.symmetric(vertical: 6 * _scaleScreen),
      //         padding: const EdgeInsets.symmetric(
      //             vertical: 12 * _scaleScreen, horizontal: 16 * _scaleScreen),
      //         decoration: BoxDecoration(
      //           borderRadius: Dimens.kBorderRadius,
      //           color: Colors.white,
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.grey.withOpacity(0.5),
      //               spreadRadius: 2,
      //               blurRadius: 5,
      //               offset: const Offset(0, 2), // changes position of shadow
      //             ),
      //           ],
      //         ),
      //         child: Column(
      //           children: [
      //             ListTile(
      //               leading: Image.asset("assets/dinner.png"),
      //               title: Text(
      //                 'Dinner',
      //                 style: Theme.of(context).textTheme.bodySmall,
      //               ),
      //               contentPadding: EdgeInsets.zero,
      //               trailing: IconButton(
      //                 onPressed: () {},
      //                 icon: Icon(
      //                   Icons.add_circle,
      //                   color: Theme.of(context).primaryColor,
      //                   size: 30 * _scaleScreen,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _buildCalendarTabView(BuildContext context) {
    return SingleChildScrollView(
      child: Container(),

      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
      //   child: Column(
      //     children: [
      //       Container(
      //         padding: const EdgeInsets.symmetric(
      //             horizontal: 16 * _scaleScreen, vertical: 16 * _scaleScreen),
      //         margin: const EdgeInsets.symmetric(vertical: 16 * _scaleScreen),
      //         width: double.infinity,
      //         decoration: BoxDecoration(
      //           borderRadius: Dimens.kBorderRadius,
      //           color: Theme.of(context).indicatorColor,
      //         ),
      //         child: Row(
      //           children: [
      //             Expanded(
      //                 child: Column(
      //               children: [
      //                 Text(
      //                   'Workout',
      //                   style: Theme.of(context).textTheme.bodySmall,
      //                 ),
      //                 Text(
      //                   '0',
      //                   style: Theme.of(context).textTheme.bodySmall,
      //                 ),
      //               ],
      //             )),
      //             Expanded(
      //                 child: Container(
      //               child: Column(
      //                 children: [
      //                   Text(
      //                     'kcal',
      //                     style: Theme.of(context).textTheme.bodySmall,
      //                   ),
      //                   Text(
      //                     '0',
      //                     style: Theme.of(context).textTheme.bodySmall,
      //                   )
      //                 ],
      //               ),
      //               decoration: BoxDecoration(
      //                 border: Border(
      //                   right:
      //                       BorderSide(color: Colors.grey.shade700, width: 1),
      //                   left: BorderSide(color: Colors.grey.shade700, width: 1),
      //                 ),
      //               ),
      //             )),
      //             Expanded(
      //               child: Column(
      //                 children: [
      //                   Text(
      //                     'Time (min)',
      //                     style:
      //                         Theme.of(context).textTheme.bodySmall!.copyWith(
      //                               fontWeight: FontWeight.w600,
      //                             ),
      //                   ),
      //                   Text(
      //                     '0',
      //                     style:
      //                         Theme.of(context).textTheme.bodySmall!.copyWith(
      //                               fontWeight: FontWeight.w600,
      //                             ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       TableCalendar(
      //         firstDay: DateTime.utc(2010, 10, 16),
      //         lastDay: DateTime.utc(2030, 3, 14),
      //         focusedDay: DateTime.now(),
      //         calendarStyle: const CalendarStyle(),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  // Widget _buildItem(BuildContext context, Schedule schedule) {
  //   return ScheduleCard(
  //     schedule: schedule,
  //     cancelMeeting:
  //         (DateTime.now().add(const Duration(hours: 2)).millisecondsSinceEpoch >
  //                 schedule.scheduleDetailInfo!.startPeriodTimestamp)
  //             ? null
  //             : () {
  //                 cancelMeeting(context, schedule.scheduleDetailId);
  //               },
  //     enterMeeting: () {
  //       enterMeeting(context, schedule);
  //     },
  //   );
  // }

  // void cancelMeeting(BuildContext context, String scheduleDetailId) {
  //   FunctionHelper.showSlidePopupDialog(
  //       context,
  //       CancelSchedulePopup(
  //         scheduleDetailId: scheduleDetailId,
  //       ),
  //       150);
  // }

  // void enterMeeting(BuildContext context, Schedule schedule) {
  //   scheduleStore.setScheduleDetail(schedule).then((value) {
  //     Navigator.of(context).pushNamed(Routes.jitsiVideoCall);
  //   });
  // }
}
