import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserStore userStore;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  int curPage = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userStore = Provider.of<UserStore>(context);
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverPersistentHeader(
        //   delegate: CustomSliverAppbarDelegate(
        //     expandedHeight: DeviceUtils.getScaledHeight(context, .3),
        //   ),
        //   floating: true,
        //   pinned: true,
        // ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
                top: Dimens.vertical_padding * 2,
                left: Dimens.horizontal_padding),
            child: Row(
              children: const <Widget>[
                // Text(
                //   AppLocalizations.of(context).translate("tutor_fav_title"),
                //   style: const TextStyle(
                //     fontWeight: FontWeight.w700,
                //     fontSize: Dimens.small_text,
                //     shadows: [
                //       Shadow(color: Colors.black54, offset: Offset(0, -8))
                //     ],
                //     color: Colors.transparent,
                //     decoration: TextDecoration.underline,
                //     decorationColor: Colors.black54,
                //     decorationThickness: 3,
                //     decorationStyle: TextDecorationStyle.solid,
                //   ),
                // ),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
            child: Column(
          children: [
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
                  //       await tutorStore.fetchTutors(page: curPage).then(
                  //           (value) => refreshController.refreshCompleted());
                  //     },
                  //     onLoading: () async {
                  //       await tutorStore
                  //           .fetchTutors(page: curPage)
                  //           .then((value) {
                  //         if (value) {
                  //           curPage++;
                  //         }
                  //         refreshController.loadComplete();
                  //       });
                  //     },
                  //     child: ListView.builder(
                  //         itemBuilder: (context, index) {
                  //           return _buildItem(
                  //               context, tutorStore.listOnlyFavTutor[index]);
                  //         },
                  //         itemCount: tutorStore.listOnlyFavTutor.length));
                },
              ),
            ),
          ],
        )),
      ],
    );
  }

  // Widget _buildItem(BuildContext context, UserInfo tutor) {
  //   return TutorCard(
  //     key: UniqueKey(),
  //     tutorInfo: tutor,
  //     toggleFavourite: (String userID) {
  //       tutorStore.toggleFavTutor(userID);
  //     },
  //   );
  // }
}

// wait loading: https://flutter.dev/docs/cookbook/effects/shimmer-loading