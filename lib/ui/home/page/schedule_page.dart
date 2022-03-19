import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  // late ScheduleStore scheduleStore;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  int curPage = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // scheduleStore = Provider.of<ScheduleStore>(context);
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.horizontal_padding,
          vertical: Dimens.vertical_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Text(
          //   AppLocalizations.of(context).translate("upcoming_title"),
          //   style: TextStyle(
          //     fontFamily: FontFamily.gilroy,
          //     fontSize: Dimens.large_text,
          //     color: Theme.of(context).primaryColor.withAlpha(200),
          //     letterSpacing: 2,
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          Expanded(
            child: Observer(
              builder: (_) {
                return Container();
                // SmartRefresher(
                //     controller: refreshController,
                //     enablePullUp: true,
                //     enablePullDown: true,
                //     header: FetchMethodWidget.fetchHeaderStatus(context),
                //     footer: FetchMethodWidget.fetchFooterStatus(),
                //     onRefresh: () async {
                //       if (curPage > 1) {
                //         curPage--;
                //       }
                //       await scheduleStore
                //           .fetchUpcomingSchedule(page: curPage)
                //           .then(
                //               (value) => refreshController.refreshCompleted());
                //     },
                //     onLoading: () async {
                //       await scheduleStore
                //           .fetchUpcomingSchedule(page: curPage)
                //           .then((value) {
                //         if (value) {
                //           curPage++;
                //         }
                //         refreshController.loadComplete();
                //       });
                //     },
                //     child: ListView.builder(
                //       itemBuilder: (context, index) {
                //         return _buildItem(context,
                //             scheduleStore.upcomingScheduleList![index]);
                //       },
                //       itemCount:
                //           scheduleStore.upcomingScheduleList?.length ?? 0,
                //     ));
              },
            ),
          ),
        ],
      ),
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
